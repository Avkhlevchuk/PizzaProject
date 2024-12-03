//
//  ProductModel.swift
//  PizzaProject
//
//  Created by Artem Khlevchuk on 26.09.2024.
//

import Foundation

struct Ingredient: Codable, Hashable {
    let id: Int
    let name: String
    let isRemovable: Bool
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case isRemovable = "is_removable"
    }
}

struct IngredientStates: Codable, Hashable, Equatable {
    let ingredient: Ingredient
    var isRemoved: Bool
}

struct Pizza: Codable {
    let id: Int
    let name: String
    var ingredients: [Ingredient]
    let ingredientsList: String
    let price: Int
    let prices: [String: Int]
    let image: String
    let foodType: FoodType
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case ingredients
        case ingredientsList = "ingredients_list"
        case price
        case prices
        case image
        case foodType = "food_type"
    }
}

struct NutritionValue {
    let id: Int
    let namePizza: String
    let weight: Int
    let calories: Int
    let protein: Int
    let fats: Int
    let carbohydrates: Int
    let mayContain: String
    let allergens: String
}

struct Toppings: Codable, Equatable {
    let id: Int
    let name: String
    let price: Double
}

extension Toppings: Comparable {
    static func < (lhs: Toppings, rhs: Toppings) -> Bool {
        lhs.id < rhs.id
    }
}

struct Order: Codable {
    let product: Pizza
    var count: Int
    let removedIngredients: [IngredientStates]
    let toppings: [Toppings]
    let sumForToppings: Double
    let priceForPizza: Double
    let sizePizza: String
    let typeBasePizza: String
}

extension Order: Equatable {
    static func == (lhs: Order, rhs: Order) -> Bool {
        lhs.product.id == rhs.product.id &&
        lhs.toppings == rhs.toppings &&
        lhs.removedIngredients == rhs.removedIngredients &&
        lhs.sizePizza == rhs.sizePizza &&
        lhs.typeBasePizza == rhs.typeBasePizza
    }
}

struct PizzaData: Codable {
    let pizza: [Pizza]
}
