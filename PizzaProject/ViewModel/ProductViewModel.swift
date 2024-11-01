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
        Pizza(id: 1, name: "Arriva", ingredients: "Tomatoes, mozzarella, pepperoni, onions, bell peppers, signature tomato sauce", price: 299, image: "arriva", foodType: .pizza),
        Pizza(id: 2, name: "Bestroganov", ingredients: "Beef, mushrooms, onions, mozzarella, stroganoff sauce", price: 359, image: "bestroganov", foodType: .pizza),
        Pizza(id: 3, name: "Burger", ingredients: "Beef, pickles, onions, cheddar, mozzarella, burger sauce", price: 329, image: "burger", foodType: .pizza),
        Pizza(id: 4, name: "Cheese Chicken", ingredients: "Chicken, mozzarella, cheddar, signature Alfredo sauce", price: 389, image: "cheesechicken", foodType: .pizza),
        Pizza(id: 5, name: "Cheese Pizza", ingredients: "Mozzarella, cheddar, signature Alfredo sauce", price: 279, image: "cheesePizza", foodType: .pizza),
        Pizza(id: 6, name: "Chicken Barbeku", ingredients: "Chicken, barbecue sauce, mozzarella, onions", price: 349, image: "chickenbarbeku", foodType: .pizza),
        Pizza(id: 7, name: "Chicken Ranch", ingredients: "Chicken, mozzarella, ranch sauce, tomatoes", price: 329, image: "chickenranch", foodType: .pizza),
        Pizza(id: 8, name: "Chorizo", ingredients: "Chorizo, mozzarella, signature tomato sauce", price: 309, image: "chorizo", foodType: .pizza),
        Pizza(id: 9, name: "Diablo", ingredients: "Pepperoni, jalapeños, mozzarella, spicy tomato sauce", price: 349, image: "diablo", foodType: .pizza),
        Pizza(id: 10, name: "Dodo", ingredients: "Pepperoni, bell peppers, mushrooms, olives, mozzarella, signature tomato sauce", price: 369, image: "dodo", foodType: .pizza),
        Pizza(id: 11, name: "Dodo Mix", ingredients: "Mixed toppings, mozzarella, signature tomato sauce", price: 389, image: "dodomix", foodType: .pizza),
        Pizza(id: 12, name: "Double Pepperoni", ingredients: "Double portion of pepperoni, mozzarella, signature tomato sauce", price: 399, image: "doublepeperoni", foodType: .pizza),
        Pizza(id: 13, name: "Four Season", ingredients: "Four sections with different toppings, mozzarella, signature tomato sauce", price: 419, image: "fourseason", foodType: .pizza),
        Pizza(id: 14, name: "Ham & Cheese", ingredients: "Ham, mozzarella, signature Alfredo sauce", price: 349, image: "ham&cheese", foodType: .pizza),
        Pizza(id: 15, name: "Ham & Mash", ingredients: "Ham, mashed potatoes, mozzarella, signature Alfredo sauce", price: 369, image: "ham&mash", foodType: .pizza),
        Pizza(id: 16, name: "Hawaii", ingredients: "Ham, pineapple, mozzarella, signature tomato sauce", price: 339, image: "hawaii", foodType: .pizza),
        Pizza(id: 17, name: "Julien", ingredients: "Mushrooms, mozzarella, creamy sauce", price: 329, image: "julien", foodType: .pizza),
        Pizza(id: 18, name: "Karbonara", ingredients: "Bacon, egg, mozzarella, Alfredo sauce", price: 369, image: "karbonara", foodType: .pizza),
        Pizza(id: 19, name: "Krevetka", ingredients: "Shrimp, tomatoes, mozzarella, garlic sauce", price: 399, image: "krevetka", foodType: .pizza),
        Pizza(id: 20, name: "Margarita", ingredients: "Tomatoes, mozzarella, signature tomato sauce", price: 279, image: "margarita", foodType: .pizza),
        Pizza(id: 21, name: "Meat", ingredients: "Various meats, mozzarella, signature tomato sauce", price: 429, image: "meat", foodType: .pizza),
        Pizza(id: 22, name: "Meat with Souse", ingredients: "Various meats, mozzarella, special sauce", price: 439, image: "meatwithsouse", foodType: .pizza),
        Pizza(id: 23, name: "Pepperoni", ingredients: "Pepperoni, mozzarella, signature tomato sauce", price: 319, image: "peperoni", foodType: .pizza),
        Pizza(id: 24, name: "Pepperoni Fresh", ingredients: "Pepperoni, tomatoes, mozzarella, signature tomato sauce", price: 329, image: "peperonifresh", foodType: .pizza),
        Pizza(id: 25, name: "Pesto", ingredients: "Basil pesto, mozzarella, tomatoes", price: 349, image: "pesto", foodType: .pizza),
        Pizza(id: 26, name: "Vegan", ingredients: "Plant-based ingredients, vegan cheese, tomato sauce", price: 359, image: "vegan", foodType: .pizza)
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
