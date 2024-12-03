//
//  CartViewModel.swift
//  PizzaProject
//
//  Created by Artem Khlevchuk on 25.11.2024.
//

import UIKit

protocol ICartViewModel {
    
    var di: DependencyContainer { get }
    
    var order: [Order] { get }
    
    var recordArchiver: OrderArchiver { get set }
    
    var totalPrice: Double { get }
    
    func getOrder()
    
    func getСalculateTotalPriceForOrder()
}

class CartViewModel: ICartViewModel {
    
    var di: DependencyContainer
    
    var recordArchiver: OrderArchiver
    
    var order: [Order] = []
    
    var totalPrice: Double = 0.0
    
    init (di: DependencyContainer) {
        self.di = di
        recordArchiver = di.orderArchiver
    }
    
    func getOrder() {
        self.order = recordArchiver.load()   
    }
    
    func getСalculateTotalPriceForOrder() {
        var totalPrice = 0.0
        
        for item in order {
            let totalPriceForPosition = (item.priceForPizza + item.sumForToppings) * Double(item.count)
            totalPrice += totalPriceForPosition
        
        }
        let roundedTotalPrice = Double(String(format: "%.1f", totalPrice)) ?? 0.0
        
        self.totalPrice = roundedTotalPrice
    }
}
