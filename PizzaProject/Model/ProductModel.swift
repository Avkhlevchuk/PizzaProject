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
}

struct IngredientStates: Codable, Hashable {
    let ingredient: Ingredient
    var isRemoved: Bool
}

struct Pizza: Codable, Hashable {
    let id: Int
    let name: String
    let ingredients: [Ingredient]
    let ingredientsList: String
    let price: Int
    let prices: [String: Int]
    let image: String
    let foodType: FoodType
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

struct Toppings: Codable {
    let id: Int
    let name: String
    let price: Double
}

struct Order: Codable {
    let product: Pizza
    let count: Int
    let removedIngredients: [IngredientStates]
    let toppings: [Toppings]
    let sumForToppings: Double
    let priceForPizza: Double
    let typeBasePizza: String
}




