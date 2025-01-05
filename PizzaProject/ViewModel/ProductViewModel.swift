//
//  ProductViewModel.swift
//  PizzaProject
//
//  Created by Artem Khlevchuk on 26.09.2024.
//

import Foundation

protocol IProductViewModel {

    var di: DependencyContainer { get set }
    var onProductUpdate: (() -> ())? { get set }
    var onFilterUpdate: (()-> ())? { get set }
    var onFilterFetch: (() -> ())? { get set }
    var onStoriesUpdate: (()-> ())? { get set }
    var onCartUpdate: ((Double)->())? { get set }
    var products: [Pizza] { get }
    var allFilters: [String] { get }
    var allStories: [String] { get }
    
    func fetchProduct(index: Int) -> Pizza
    func fetchProducts()
    func getProducts()
    func getFilters()
    func getStories()
    func fetchFilters()
    func getCartTotal()
    func fetchIndexSelectedCategory(selectedFoodType: String) -> IndexPath
    
}

class ProductViewModel: IProductViewModel {
    
    var di: DependencyContainer
    private let orderArchiver: OrderArchiver
    
    var onProductUpdate: (()-> ())?
    var onFilterUpdate: (()-> ())?
    var onStoriesUpdate: (()-> ())?
    var onFilterFetch: (()-> ())?
    var onCartUpdate: ((Double)->())?
    
    private(set) var products: [Pizza] = []
    
    init (di: DependencyContainer) {
        self.di = di
        orderArchiver = di.orderArchiver
    }
    
    var allFilters = [String]()
    
    var allStories = [String]()
    
    func fetchProduct(index: Int) -> Pizza {
        return products[index]
    }
    
    func fetchProducts() {
        onProductUpdate?()
    }
    
    func getProducts() {
        Task(priority: .background) {
            let result = await di.productLoader.getProduct()
            switch result {
            case .success(let product):
                DispatchQueue.main.async {
                    self.products = product
                    self.onProductUpdate?()
                }
            case .failure(_):
                print("Error")
            }
        }
    }
    
    func getFilters() {
        Task(priority: .background) {
            let result = await di.productLoader.getFilter()
            switch result {
            case .success(let filter):
                self.allFilters = filter
                DispatchQueue.main.async {
                    self.onFilterUpdate?()
                }
            case .failure(_):
                print("Error")
            }
        }
    }
    
    func getStories() {
        Task(priority: .background) {
            let result = await di.productLoader.getStory()
            switch result {
            case .success(let story):
                self.allStories = story
                DispatchQueue.main.async {
                    self.onStoriesUpdate?()
                }
            case .failure(_):
                print("Error")
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
            
            onCartUpdate?(roundedTotalPrice)
        } else {
            onCartUpdate?(0.0)
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
