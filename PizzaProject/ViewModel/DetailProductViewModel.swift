//
//  DetailProductViewModel.swift
//  PizzaProject
//
//  Created by Artem Khlevchuk on 01.11.2024.
//

import Foundation

class DetailProductViewModel {
    
    var product: Pizza
    
    var onProductUpdate: (()-> ())?
    
    init (product: Pizza) {
        self.product = product
    }
    
    func getProduct() -> Pizza {
        return product
    }
    
    func updateProduct(_ product: Pizza) {
        self.product = product
        onProductUpdate?()
    }
}
