//
//  ProductViewModel.swift
//  PizzaProject
//
//  Created by Artem Khlevchuk on 26.09.2024.
//

import Foundation

class ProductViewModel {
    
    var onProductUpdate: (()-> ())?
    var onFilterFetch: (()-> ())?

    let products: [Pizza] = [
            Pizza(id: 1, name: "Cheese", ingredients: "Mozzarella, cheddar and parmesan cheeses, signature Alfredo sauce", price: 279, image: "margarita", foodType: .pizza),
            Pizza(id: 2, name: "Pepperoni Fresh", ingredients: "Spicy pepperoni, increased portion of mozzarella, tomatoes, signature tomato sauce", price: 329, image: "pepperoni", foodType: .pizza),
            Pizza(id: 3, name: "Double Chicken", ingredients: "Chicken, mozzarella, signature Alfredo sauce", price: 429, image: "hawaii", foodType: .pizza),
            Pizza(id: 4, name: "Ham and Cheese", ingredients: "Ham, mozzarella, signature Alfredo sauce", price: 349, image: "margarita", foodType: .pizza),
            Pizza(id: 5, name: "Triple Pepperoni", ingredients: "Spicy pepperoni, increased portion of mozzarella, tomatoes, signature tomato sauce", price: 777, image: "default", foodType: .pizza)
        ]
    
    let allFilters = [FoodType.romanPizza, FoodType.pizza, FoodType.combo, FoodType.snack, FoodType.breakfast, FoodType.milkshake, FoodType.drink, FoodType.coffee]
    
    let allStories = ["stories", "stories1", "stories2", "stories3", "stories", "stories1", "stories2", "stories3"]
    
    let allToppings = [
        Toppings(name: "cheese", price: "100 ₽"),
        Toppings(name: "halapeno", price: "120 ₽"),
        Toppings(name: "mushrooms", price: "80 ₽"),
        Toppings(name: "onion", price: "50 ₽"),
        Toppings(name: "sausage", price: "150 ₽"),
        Toppings(name: "tomato", price: "60 ₽")
    ]
    
    func fetchProduct(index: Int) -> Pizza {
        return products[index]
    }
    
    func fetchProducts() {
        onProductUpdate?()
    }
    
    func fetchFilters() {
        onFilterFetch?()
    }
}
