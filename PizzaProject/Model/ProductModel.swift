//
//  ProductModel.swift
//  PizzaProject
//
//  Created by Artem Khlevchuk on 26.09.2024.
//

import Foundation

class ProductModel {
 
}

struct Pizza: Codable {
    let id: Int
    let name: String
    let ingredients: String
    let price: Int
    let image: String
    let foodType: FoodType
}

struct Toppings: Codable {
    let name: String
    let price: String
}

struct Order: Codable {
    let product: Pizza
    let count: Int
    let toppings: [Toppings]
}


