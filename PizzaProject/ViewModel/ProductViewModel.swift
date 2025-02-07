import Foundation

enum ProductViewModelState {
    case loading
    case loaded
    case error
}

protocol IProductViewModel {
    
    var di: DependencyContainer { get set }
    var onProductUpdate: (() -> ())? { get set }
    var onFilterUpdate: (()-> ())? { get set }
    var onFilterFetch: (() -> ())? { get set }
    var onStoriesUpdate: (()-> ())? { get set }
    var onCartUpdate: (()->())? { get set }
    var onUpdateState: (() -> Void)? { get set }
    var products: [Pizza] { get }
    var allFilters: [String] { get }
    var allStories: [String] { get }
    var state: ProductViewModelState { get set }
    var totalPriceCart: Double? { get set}
    
    func fetchProduct(index: Int) -> Pizza
    func fetchProducts()
    func getData()
    func fetchFilters()
    func getCartTotal()
    func fetchIndexSelectedCategory(selectedFoodType: String) -> IndexPath
    
}

final class ProductViewModel: IProductViewModel {
    
    var state: ProductViewModelState {
        didSet {
            onUpdateState?()
        }
    }
    
    var di: DependencyContainer
    private let orderArchiver: OrderArchiver
    
    var onProductUpdate: (()-> ())?
    var onFilterUpdate: (()-> ())?
    var onStoriesUpdate: (()-> ())?
    var onFilterFetch: (()-> ())?
    var onCartUpdate: (()->())?
    
    var onUpdateState: (() -> Void)?
    
    private(set) var products: [Pizza] = []
    
    var allFilters = [String]()
    
    var allStories = [String]()
    
    var totalPriceCart: Double? {
        didSet {
            onCartUpdate?()
        }
    }
    
    init (di: DependencyContainer) {
        self.di = di
        orderArchiver = di.orderArchiver
        self.state = .loading
    }
    
    
    func fetchProduct(index: Int) -> Pizza {
        return products[index]
    }
    
    func fetchProducts() {
        onProductUpdate?()
    }
    
    func getData() {
        
        Task(priority: .background) {
            await withTaskGroup(of: Void.self) { group in
                let tasks: [()] = [
                    group.addTask {
                        let result = await self.di.productLoader.getProduct()
                        await MainActor.run {
                            switch result {
                            case .success(let product):
                                self.products = product
                            case .failure(_):
                                print("Error")
                                self.state = .error
                            }
                        }
                    },
                    
                    group.addTask {
                        let result = await self.di.productLoader.getFilter()
                        await MainActor.run {
                            switch result {
                            case .success(let filter):
                                self.allFilters = filter
                            case .failure(_):
                                print("Error")
                                self.state = .error
                            }
                        }
                    },
                    
                    group.addTask {
                        let result = await self.di.productLoader.getStory()
                        await MainActor.run {
                            switch result {
                            case .success(let story):
                                self.allStories = story
                            case .failure(_):
                                print("Error")
                                self.state = .error
                            }
                        }
                    }
                ]
                
                for _ in tasks {
                    await group.next()
                }
                
                await MainActor.run {
                    self.state = (products.isEmpty || allFilters.isEmpty || allStories.isEmpty) ? .error : .loaded
                }
            }
        }
    }
    
    func fetchFilters() {
        onFilterFetch?()
    }
    
    //MARK: - Cart func
    func getCartTotal() {
        let cart =  di.orderArchiver.load()
        
        if cart.isNotEmpty {
            let totalPrice = cart.reduce(0.0) { $0 + ($1.priceForPizza + $1.sumForToppings) * Double($1.count) }
            
            let roundedTotalPrice = Double(String(format: "%.1f", totalPrice)) ?? 0.0
            
            totalPriceCart = roundedTotalPrice
        } else {
            totalPriceCart = 0.0
        }
    }
}

//MARK: - Event Handler

extension ProductViewModel {
    
    func fetchIndexSelectedCategory(selectedFoodType: String) -> IndexPath {
        if let index = products.firstIndex(where: {$0.foodType == selectedFoodType}) {
            return IndexPath(row: index, section: 2)
        }
        return IndexPath(row: 0, section: 2)
    }
}
