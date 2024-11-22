//
//  DetailProductViewModel.swift
//  PizzaProject
//
//  Created by Artem Khlevchuk on 01.11.2024.
//

import Foundation

protocol IDetailProductViewModel {
    
    var product: Pizza { get set }
    var nutrition: [NutritionValue] { get set }
    var order: [Order] { get set }
    var priceForPizza: Double { get set }
    
    var sumToppings: Double  { get set }
    
    var typeBasePizza: String { get set }
    
    var allToppings: [Toppings] { get set }
    
    var ingretientStatesInOrder: [IngredientStates] { get set }
    
    var onProductUpdate: (()-> ())? { get set }
    
    var toppingsInOrder: [Toppings] { get set }
    
    func getProduct() -> Pizza
    
    func getNutritionValue(id: Int) -> NutritionValue
    
    func updateProduct(_ product: Pizza)
    
    func calculateTotalPrice(topping: Toppings, priceForPizza: Double) -> Double
    
    func addToCard(product: Pizza,removedIngredients: [IngredientStates], toppings: [Toppings], sumForToppings: Double, priceForPizza: Double, typeBasePizza: String)
    
    func resetRemovedIngredientStates()
    
}

class DetailProductViewModel: IDetailProductViewModel {
    
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
    
    var priceForPizza: Double = 0.0
    
    var sumToppings: Double = 0.0
    
    var typeBasePizza: String = "thin"
    
    var allToppings = [
        Toppings(id: 1, name: "cheese", price: 1.0),
        Toppings(id: 2, name: "halapeno", price: 1.2),
        Toppings(id: 3, name: "mushrooms", price: 0.8),
        Toppings(id: 4, name: "onion", price: 0.5),
        Toppings(id: 5, name: "sausage", price: 1.5),
        Toppings(id: 6, name: "tomato", price: 0.6)
    ]
    
    var ingretientStatesInOrder: [IngredientStates] = []
    
    var onProductUpdate: (()-> ())?
    
    var toppingsInOrder = [Toppings]()
    
    let recordArchiver = RecordArchiver.shared
    
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
    
    func calculateTotalPrice(topping: Toppings, priceForPizza: Double) -> Double {
        
        if toppingsInOrder.isEmpty {
            toppingsInOrder.append(topping)
            sumToppings += topping.price
        } else if toppingsInOrder.contains(where: { $0.id == topping.id }) {
            toppingsInOrder.removeAll { $0.id == topping.id }
            sumToppings -= topping.price
        } else {
            toppingsInOrder.append(topping)
            sumToppings += topping.price
        }
        
        let roundedSum = (sumToppings * 10).rounded() / 10
        
        let totalPrice = Double(priceForPizza) + roundedSum
        
        return totalPrice
    }
    
    func addToCard(product: Pizza,removedIngredients: [IngredientStates], toppings: [Toppings], sumForToppings: Double, priceForPizza: Double, typeBasePizza: String) {
        let order = Order(product: product, count: 1, removedIngredients: removedIngredients, toppings: toppings, sumForToppings: sumForToppings, priceForPizza: priceForPizza, typeBasePizza: typeBasePizza)

        recordArchiver.save(order: [order])
    }
    
    func resetRemovedIngredientStates() {        
        for index in ingretientStatesInOrder.indices {
            ingretientStatesInOrder[index].isRemoved = false
        }
    }
}
