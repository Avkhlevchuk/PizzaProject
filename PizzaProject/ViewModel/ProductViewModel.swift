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
    var onFilterFetch: (() -> ())? { get set }
    
    var products: [Pizza] { get }
    var allFilters: [String] { get }
    
    func fetchProduct(index: Int) -> Pizza
    func fetchProducts()
    func getProducts()
    func fetchFilters()
    
    //Cart
    
    var onCartUpdate: ((Double)->())? { get set }
    
    func getCartTotal()
    
    //Event Handler
    
    func fetchIndexSelectedCategory(selectedFoodType: String) -> IndexPath
    
}

class ProductViewModel: IProductViewModel {
    
    var di: DependencyContainer
    
    let orderArchiver: OrderArchiver
    
    var onProductUpdate: (()-> ())?
    var onFilterFetch: (()-> ())?
    
    var onCartUpdate: ((Double)->())?
    
    var products: [Pizza] = []
    
    init (di: DependencyContainer) {
        self.di = di
        orderArchiver = di.orderArchiver
    }
    
    let allFilters = ["Roman Pizza", "Pizza", "Combo", "Snack", "Breakfast", "Milkshakes", "Coffee", "Drink"]
    
    let allStories = ["stories", "stories1", "stories2", "stories3", "stories", "stories1", "stories2", "stories3"]
    
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
                self.products = product
                DispatchQueue.main.async {
                    self.onProductUpdate?()
                }
            case .failure(let error):
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
