//
//  CartViewModel.swift
//  PizzaProject
//
//  Created by Artem Khlevchuk on 25.11.2024.
//

import UIKit

protocol ICartViewModel {
    var order: [Order] { get }
    
    var totalPrice: Double { get }
    
    func getOrder()
    
    func getСalculateTotalPriceForOrder()
}

class CartViewModel: ICartViewModel {
    
    var recordArchiver = RecordArchiver.shared
    
    var order: [Order] = []
    
    var totalPrice: Double = 0.0
    
    func getOrder() {
        self.order = recordArchiver.load()   
    }
    
    func getСalculateTotalPriceForOrder() {
        var totalPrice = 0.0
        
        for item in order {
            let totalPriceForPosition = (item.priceForPizza + item.sumForToppings) * Double(item.count)
            totalPrice += totalPriceForPosition
        
        }
        
        self.totalPrice = totalPrice
    }
}
