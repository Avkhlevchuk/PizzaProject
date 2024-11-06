//
//  DetailProductViewModel.swift
//  PizzaProject
//
//  Created by Artem Khlevchuk on 01.11.2024.
//

import Foundation

class DetailProductViewModel {
    
    var product: Pizza
    
    var nutrition: [NutritionValue] = [
        NutritionValue(id: 1, namePizza: "Arriva", weight: 580, calories: 300, protein: 14, fats: 13, carbohydrates: 28, mayContain: "gluten, milk and its products (including lactose)", allergens: "vdo.do/ru_nutrition"),
            NutritionValue(id: 2, namePizza: "Bestroganov", weight: 600, calories: 320, protein: 14, fats: 15, carbohydrates: 30, mayContain: "gluten, milk and its products (including lactose)", allergens: "vdo.do/ru_nutrition"),
            NutritionValue(id: 3, namePizza: "Burger", weight: 590, calories: 310, protein: 13, fats: 14, carbohydrates: 29, mayContain: "gluten, milk and its products (including lactose)", allergens: "vdo.do/ru_nutrition"),
            NutritionValue(id: 4, namePizza: "Cheese Chicken", weight: 570, calories: 295, protein: 12, fats: 13, carbohydrates: 27, mayContain: "gluten, milk and its products (including lactose)", allergens: "vdo.do/ru_nutrition"),
            NutritionValue(id: 5, namePizza: "Cheese Pizza", weight: 550, calories: 280, protein: 11, fats: 12, carbohydrates: 25, mayContain: "gluten, milk and its products (including lactose)", allergens: "vdo.do/ru_nutrition"),
            NutritionValue(id: 6, namePizza: "Chicken Barbeku", weight: 580, calories: 300, protein: 12, fats: 13, carbohydrates: 28, mayContain: "gluten, milk and its products (including lactose)", allergens: "vdo.do/ru_nutrition"),
            NutritionValue(id: 7, namePizza: "Chicken Ranch", weight: 570, calories: 295, protein: 12, fats: 13, carbohydrates: 27, mayContain: "gluten, milk and its products (including lactose)", allergens: "vdo.do/ru_nutrition"),
            NutritionValue(id: 8, namePizza: "Chorizo", weight: 560, calories: 290, protein: 11, fats: 12, carbohydrates: 26, mayContain: "gluten, milk and its products (including lactose)", allergens: "vdo.do/ru_nutrition"),
            NutritionValue(id: 9, namePizza: "Diablo", weight: 580, calories: 305, protein: 12, fats: 15, carbohydrates: 29, mayContain: "gluten, milk and its products (including lactose)", allergens: "vdo.do/ru_nutrition"),
            NutritionValue(id: 10, namePizza: "Mexico", weight: 590, calories: 310, protein: 13, fats: 14, carbohydrates: 29, mayContain: "gluten, milk and its products (including lactose)", allergens: "vdo.do/ru_nutrition"),
            NutritionValue(id: 11, namePizza: "Mexico Mix", weight: 590, calories: 315, protein: 13, fats: 14, carbohydrates: 30, mayContain: "gluten, milk and its products (including lactose)", allergens: "vdo.do/ru_nutrition"),
            NutritionValue(id: 12, namePizza: "Double Pepperoni", weight: 560, calories: 290, protein: 11, fats: 13, carbohydrates: 26, mayContain: "gluten, milk and its products (including lactose)", allergens: "vdo.do/ru_nutrition"),
            NutritionValue(id: 13, namePizza: "Four Season", weight: 590, calories: 320, protein: 14, fats: 15, carbohydrates: 30, mayContain: "gluten, milk and its products (including lactose)", allergens: "vdo.do/ru_nutrition"),
            NutritionValue(id: 14, namePizza: "Ham & Cheese", weight: 570, calories: 300, protein: 12, fats: 13, carbohydrates: 28, mayContain: "gluten, milk and its products (including lactose)", allergens: "vdo.do/ru_nutrition"),
            NutritionValue(id: 15, namePizza: "Ham & Mash", weight: 580, calories: 305, protein: 12, fats: 14, carbohydrates: 29, mayContain: "gluten, milk and its products (including lactose)", allergens: "vdo.do/ru_nutrition"),
            NutritionValue(id: 16, namePizza: "Hawaii", weight: 580, calories: 295, protein: 12, fats: 13, carbohydrates: 27, mayContain: "gluten, milk and its products (including lactose)", allergens: "vdo.do/ru_nutrition"),
            NutritionValue(id: 17, namePizza: "Julien", weight: 550, calories: 280, protein: 11, fats: 12, carbohydrates: 25, mayContain: "gluten, milk and its products (including lactose)", allergens: "vdo.do/ru_nutrition"),
            NutritionValue(id: 18, namePizza: "Karbonara", weight: 570, calories: 295, protein: 12, fats: 13, carbohydrates: 27, mayContain: "gluten, milk and its products (including lactose)", allergens: "vdo.do/ru_nutrition"),
            NutritionValue(id: 19, namePizza: "Krevetka", weight: 590, calories: 310, protein: 13, fats: 14, carbohydrates: 29, mayContain: "gluten, milk and its products (including lactose), shellfish", allergens: "vdo.do/ru_nutrition"),
            NutritionValue(id: 20, namePizza: "Margarita", weight: 550, calories: 270, protein: 11, fats: 12, carbohydrates: 25, mayContain: "gluten, milk and its products (including lactose)", allergens: "vdo.do/ru_nutrition"),
            NutritionValue(id: 21, namePizza: "Meat", weight: 600, calories: 330, protein: 15, fats: 16, carbohydrates: 32, mayContain: "gluten, milk and its products (including lactose)", allergens: "vdo.do/ru_nutrition"),
            NutritionValue(id: 22, namePizza: "Meat with Souse", weight: 600, calories: 330, protein: 15, fats: 16, carbohydrates: 32, mayContain: "gluten, milk and its products (including lactose)", allergens: "vdo.do/ru_nutrition"),
            NutritionValue(id: 23, namePizza: "Pepperoni", weight: 560, calories: 290, protein: 11, fats: 13, carbohydrates: 26, mayContain: "gluten, milk and its products (including lactose)", allergens: "vdo.do/ru_nutrition"),
            NutritionValue(id: 24, namePizza: "Pepperoni Fresh", weight: 560, calories: 290, protein: 11, fats: 13, carbohydrates: 26, mayContain: "gluten, milk and its products (including lactose)", allergens: "vdo.do/ru_nutrition"),
            NutritionValue(id: 25, namePizza: "Pesto", weight: 550, calories: 270, protein: 11, fats: 12, carbohydrates: 25, mayContain: "gluten, milk and its products (including lactose)", allergens: "vdo.do/ru_nutrition"),
            NutritionValue(id: 26, namePizza: "Vegan", weight: 540, calories: 250, protein: 10, fats: 10, carbohydrates: 24, mayContain: "may contain traces of gluten and milk", allergens: "vdo.do/ru_nutrition")
    ]
    
    var order = [Order]()
    
    var onProductUpdate: (()-> ())?
    
    init (product: Pizza) {
        self.product = product
    }
    
    func getProduct() -> Pizza {
        return product
    }
    
    func getNutritionValue(id: Int) -> NutritionValue {
        return nutrition.first { $0.id == id } ?? nutrition[0]
    }
    
    func updateProduct(_ product: Pizza) {
        self.product = product
        onProductUpdate?()
    }
}
