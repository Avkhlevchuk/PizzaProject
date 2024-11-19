//
//  ProductViewModel.swift
//  PizzaProject
//
//  Created by Artem Khlevchuk on 26.09.2024.
//

import Foundation

protocol IProductViewModel {
    
    var di: DependencyContainer? { get set }
    
    var onProductUpdate: (() -> ())? { get set }
    var onFilterFetch: (() -> ())? { get set }
    
    var products: [Pizza] { get }
    var allFilters: [FoodType] { get }
    
    func fetchProduct(index: Int) -> Pizza
    func fetchProducts()
    func fetchFilters()
    
}

class ProductViewModel: IProductViewModel {
    
    var di: DependencyContainer?
    
    var onProductUpdate: (()-> ())?
    var onFilterFetch: (()-> ())?

    let products: [Pizza] = [
        Pizza(
               id: 1,
               name: "Arriva",
               ingredients: [
                   Ingredient(id: 1, name: "Tomatoes", isRemovable: false),
                   Ingredient(id: 2, name: "Mozzarella", isRemovable: true),
                   Ingredient(id: 3, name: "Pepperoni", isRemovable: false),
                   Ingredient(id: 4, name: "Onions", isRemovable: true),
                   Ingredient(id: 5, name: "Bell Peppers", isRemovable: false),
                   Ingredient(id: 6, name: "Signature Tomato Sauce", isRemovable: true)
               ],
               ingredientsList: "Tomatoes, mozzarella, pepperoni, onions, bell peppers, signature tomato sauce",
               price: 25,
               prices: ["small": 15, "medium": 25, "large": 30],
               image: "arriva",
               foodType: .pizza
           ),
           Pizza(
               id: 2,
               name: "Bestroganov",
               ingredients: [
                   Ingredient(id: 7, name: "Beef", isRemovable: false),
                   Ingredient(id: 8, name: "Mushrooms", isRemovable: true),
                   Ingredient(id: 4, name: "Onions", isRemovable: true),
                   Ingredient(id: 2, name: "Mozzarella", isRemovable: true),
                   Ingredient(id: 9, name: "Stroganoff Sauce", isRemovable: false)
               ],
               ingredientsList: "Beef, mushrooms, onions, mozzarella, stroganoff sauce",
               price: 25,
               prices: ["small": 15, "medium": 25, "large": 30],
               image: "bestroganov",
               foodType: .pizza
           ),
           Pizza(
               id: 3,
               name: "Burger",
               ingredients: [
                   Ingredient(id: 7, name: "Beef", isRemovable: false),
                   Ingredient(id: 10, name: "Pickles", isRemovable: true),
                   Ingredient(id: 4, name: "Onions", isRemovable: true),
                   Ingredient(id: 11, name: "Cheddar", isRemovable: false),
                   Ingredient(id: 2, name: "Mozzarella", isRemovable: true),
                   Ingredient(id: 12, name: "Burger Sauce", isRemovable: false)
               ],
               ingredientsList: "Beef, pickles, onions, cheddar, mozzarella, burger sauce",
               price: 25,
               prices: ["small": 15, "medium": 25, "large": 30],
               image: "burger",
               foodType: .pizza
           ),
           Pizza(
               id: 4,
               name: "Cheese Chicken",
               ingredients: [
                   Ingredient(id: 13, name: "Chicken", isRemovable: false),
                   Ingredient(id: 2, name: "Mozzarella", isRemovable: true),
                   Ingredient(id: 11, name: "Cheddar", isRemovable: false),
                   Ingredient(id: 14, name: "Signature Alfredo Sauce", isRemovable: true)
               ],
               ingredientsList: "Chicken, mozzarella, cheddar, signature alfredo sauce",
               price: 20,
               prices: ["small": 15, "medium": 20, "large": 30],
               image: "cheesechicken",
               foodType: .pizza
           ),
           Pizza(
               id: 5,
               name: "Cheese Pizza",
               ingredients: [
                   Ingredient(id: 2, name: "Mozzarella", isRemovable: true),
                   Ingredient(id: 11, name: "Cheddar", isRemovable: false),
                   Ingredient(id: 14, name: "Signature Alfredo Sauce", isRemovable: true)
               ],
               ingredientsList: "Mozzarella, cheddar, signature alfredo sauce",
               price: 15,
               prices: ["small": 10, "medium": 15, "large": 25],
               image: "cheesePizza",
               foodType: .pizza
           ),
           Pizza(
               id: 6,
               name: "Chicken Barbeku",
               ingredients: [
                   Ingredient(id: 13, name: "Chicken", isRemovable: false),
                   Ingredient(id: 15, name: "Barbecue Sauce", isRemovable: true),
                   Ingredient(id: 2, name: "Mozzarella", isRemovable: true),
                   Ingredient(id: 4, name: "Onions", isRemovable: true)
               ],
               ingredientsList: "Chicken, barbecue sauce, mozzarella, onions",
               price: 20,
               prices: ["small": 15, "medium": 20, "large": 30],
               image: "chickenbarbeku",
               foodType: .pizza
           ),
           Pizza(
               id: 7,
               name: "Chicken Ranch",
               ingredients: [
                   Ingredient(id: 13, name: "Chicken", isRemovable: false),
                   Ingredient(id: 2, name: "Mozzarella", isRemovable: true),
                   Ingredient(id: 16, name: "Ranch Sauce", isRemovable: true),
                   Ingredient(id: 1, name: "Tomatoes", isRemovable: false)
               ],
               ingredientsList: "Chicken, mozzarella, ranch sauce, tomatoes",
               price: 20,
               prices: ["small": 15, "medium": 20, "large": 30],
               image: "chickenranch",
               foodType: .pizza
           ),
           Pizza(
               id: 8,
               name: "Chorizo",
               ingredients: [
                   Ingredient(id: 17, name: "Chorizo", isRemovable: false),
                   Ingredient(id: 2, name: "Mozzarella", isRemovable: true),
                   Ingredient(id: 6, name: "Signature Tomato Sauce", isRemovable: true)
               ],
               ingredientsList: "Chorizo, mozzarella, signature tomato sauce",
               price: 20,
               prices: ["small": 15, "medium": 20, "large": 30],
               image: "chorizo",
               foodType: .pizza
           ),
           Pizza(
               id: 9,
               name: "Diablo",
               ingredients: [
                   Ingredient(id: 3, name: "Pepperoni", isRemovable: false),
                   Ingredient(id: 18, name: "Jalapeños", isRemovable: true),
                   Ingredient(id: 2, name: "Mozzarella", isRemovable: true),
                   Ingredient(id: 19, name: "Spicy Tomato Sauce", isRemovable: true)
               ],
               ingredientsList: "Pepperoni, jalapeños, mozzarella, spicy tomato sauce",
               price: 20,
               prices: ["small": 15, "medium": 20, "large": 30],
               image: "diablo",
               foodType: .pizza
           ),
           Pizza(
               id: 10,
               name: "Mexico",
               ingredients: [
                   Ingredient(id: 3, name: "Pepperoni", isRemovable: false),
                   Ingredient(id: 5, name: "Bell Peppers", isRemovable: false),
                   Ingredient(id: 8, name: "Mushrooms", isRemovable: true),
                   Ingredient(id: 20, name: "Olives", isRemovable: true),
                   Ingredient(id: 2, name: "Mozzarella", isRemovable: true),
                   Ingredient(id: 6, name: "Signature Tomato Sauce", isRemovable: true)
               ],
               ingredientsList: "Pepperoni, bell peppers, mushrooms, olives, mozzarella, signature tomato sauce",
               price: 25,
               prices: ["small": 15, "medium": 25, "large": 30],
               image: "dodo",
               foodType: .pizza
           ),
        Pizza(
               id: 11,
               name: "Mexico Mix",
               ingredients: [
                   Ingredient(id: 21, name: "Mixed Toppings", isRemovable: false),
                   Ingredient(id: 2, name: "Mozzarella", isRemovable: true),
                   Ingredient(id: 6, name: "Signature Tomato Sauce", isRemovable: true)
               ],
               ingredientsList: "Mixed toppings, mozzarella, signature tomato sauce",
               price: 25,
               prices: ["small": 15, "medium": 25, "large": 30],
               image: "dodomix",
               foodType: .pizza
           ),
           Pizza(
               id: 12,
               name: "Double Pepperoni",
               ingredients: [
                   Ingredient(id: 3, name: "Pepperoni", isRemovable: false),
                   Ingredient(id: 2, name: "Mozzarella", isRemovable: true),
                   Ingredient(id: 6, name: "Signature Tomato Sauce", isRemovable: true)
               ],
               ingredientsList: "Pepperoni, mozzarella, signature tomato sauce",
               price: 20,
               prices: ["small": 15, "medium": 20, "large": 30],
               image: "doublepeperoni",
               foodType: .pizza
           ),
           Pizza(
               id: 13,
               name: "Four Season",
               ingredients: [
                   Ingredient(id: 22, name: "Four Sections with Different Toppings", isRemovable: false),
                   Ingredient(id: 2, name: "Mozzarella", isRemovable: true),
                   Ingredient(id: 6, name: "Signature Tomato Sauce", isRemovable: true)
               ],
               ingredientsList: "Four sections with different toppings, mozzarella, signature tomato sauce",
               price: 25,
               prices: ["small": 15, "medium": 25, "large": 30],
               image: "fourseason",
               foodType: .pizza
           ),
           Pizza(
               id: 14,
               name: "Ham & Cheese",
               ingredients: [
                   Ingredient(id: 23, name: "Ham", isRemovable: true),
                   Ingredient(id: 2, name: "Mozzarella", isRemovable: true),
                   Ingredient(id: 14, name: "Signature Alfredo Sauce", isRemovable: true)
               ],
               ingredientsList: "Ham, mozzarella, signature alfredo sauce",
               price: 20,
               prices: ["small": 15, "medium": 20, "large": 30],
               image: "ham&cheese",
               foodType: .pizza
           ),
           Pizza(
               id: 15,
               name: "Ham & Mash",
               ingredients: [
                   Ingredient(id: 23, name: "Ham", isRemovable: true),
                   Ingredient(id: 24, name: "Mashed Potatoes", isRemovable: false),
                   Ingredient(id: 2, name: "Mozzarella", isRemovable: true),
                   Ingredient(id: 14, name: "Signature Alfredo Sauce", isRemovable: true)
               ],
               ingredientsList: "Ham, mashed potatoes, mozzarella, signature alfredo sauce",
               price: 20,
               prices: ["small": 15, "medium": 20, "large": 30],
               image: "ham&mash",
               foodType: .pizza
           ),
           Pizza(
               id: 16,
               name: "Hawaii",
               ingredients: [
                   Ingredient(id: 23, name: "Ham", isRemovable: true),
                   Ingredient(id: 25, name: "Pineapple", isRemovable: false),
                   Ingredient(id: 2, name: "Mozzarella", isRemovable: true),
                   Ingredient(id: 6, name: "Signature Tomato Sauce", isRemovable: true)
               ],
               ingredientsList: "Ham, pineapple, mozzarella, signature tomato sauce",
               price: 20,
               prices: ["small": 15, "medium": 20, "large": 30],
               image: "hawaii",
               foodType: .pizza
           ),
           Pizza(
               id: 17,
               name: "Julien",
               ingredients: [
                   Ingredient(id: 8, name: "Mushrooms", isRemovable: true),
                   Ingredient(id: 2, name: "Mozzarella", isRemovable: true),
                   Ingredient(id: 26, name: "Creamy Sauce", isRemovable: false)
               ],
               ingredientsList: "Mushrooms, mozzarella, creamy sauce",
               price: 15,
               prices: ["small": 10, "medium": 15, "large": 25],
               image: "julien",
               foodType: .pizza
           ),
           Pizza(
               id: 18,
               name: "Karbonara",
               ingredients: [
                   Ingredient(id: 27, name: "Bacon", isRemovable: false),
                   Ingredient(id: 28, name: "Egg", isRemovable: false),
                   Ingredient(id: 2, name: "Mozzarella", isRemovable: true),
                   Ingredient(id: 14, name: "Signature Alfredo Sauce", isRemovable: true)
               ],
               ingredientsList: "Bacon, egg, mozzarella, signature alfredo sauce",
               price: 20,
               prices: ["small": 15, "medium": 20, "large": 30],
               image: "karbonara",
               foodType: .pizza
           ),
           Pizza(
               id: 19,
               name: "Krevetka",
               ingredients: [
                   Ingredient(id: 29, name: "Shrimp", isRemovable: true),
                   Ingredient(id: 1, name: "Tomatoes", isRemovable: false),
                   Ingredient(id: 2, name: "Mozzarella", isRemovable: true),
                   Ingredient(id: 30, name: "Garlic Sauce", isRemovable: false)
               ],
               ingredientsList: "Shrimp, tomatoes, mozzarella, garlic sauce",
               price: 25,
               prices: ["small": 15, "medium": 25, "large": 30],
               image: "krevetka",
               foodType: .pizza
           ),
           Pizza(
               id: 20,
               name: "Margarita",
               ingredients: [
                   Ingredient(id: 1, name: "Tomatoes", isRemovable: false),
                   Ingredient(id: 2, name: "Mozzarella", isRemovable: true),
                   Ingredient(id: 6, name: "Signature Tomato Sauce", isRemovable: true)
               ],
               ingredientsList: "Tomatoes, mozzarella, signature tomato sauce",
               price: 15,
               prices: ["small": 10, "medium": 15, "large": 25],
               image: "margarita",
               foodType: .pizza
           ),
        Pizza(
               id: 21,
               name: "Meat",
               ingredients: [
                   Ingredient(id: 31, name: "Various Meats", isRemovable: true),
                   Ingredient(id: 2, name: "Mozzarella", isRemovable: true),
                   Ingredient(id: 6, name: "Signature Tomato Sauce", isRemovable: true)
               ],
               ingredientsList: "Various meats, mozzarella, signature tomato sauce",
               price: 25,
               prices: ["small": 15, "medium": 25, "large": 30],
               image: "meat",
               foodType: .pizza
           ),
           Pizza(
               id: 22,
               name: "Meat with Sauce",
               ingredients: [
                   Ingredient(id: 31, name: "Various Meats", isRemovable: true),
                   Ingredient(id: 2, name: "Mozzarella", isRemovable: true),
                   Ingredient(id: 32, name: "Special Sauce", isRemovable: false)
               ],
               ingredientsList: "Various meats, mozzarella, special sauce",
               price: 25,
               prices: ["small": 15, "medium": 25, "large": 30],
               image: "meatwithsouse",
               foodType: .pizza
           ),
           Pizza(
               id: 23,
               name: "Pepperoni",
               ingredients: [
                   Ingredient(id: 3, name: "Pepperoni", isRemovable: false),
                   Ingredient(id: 2, name: "Mozzarella", isRemovable: true),
                   Ingredient(id: 6, name: "Signature Tomato Sauce", isRemovable: true)
               ],
               ingredientsList: "Pepperoni, mozzarella, signature tomato sauce",
               price: 20,
               prices: ["small": 15, "medium": 20, "large": 30],
               image: "peperoni",
               foodType: .pizza
           ),
           Pizza(
               id: 24,
               name: "Pepperoni Fresh",
               ingredients: [
                   Ingredient(id: 3, name: "Pepperoni", isRemovable: false),
                   Ingredient(id: 1, name: "Tomatoes", isRemovable: false),
                   Ingredient(id: 2, name: "Mozzarella", isRemovable: true),
                   Ingredient(id: 6, name: "Signature Tomato Sauce", isRemovable: true)
               ],
               ingredientsList: "Pepperoni, tomatoes, mozzarella, signature tomato sauce",
               price: 20,
               prices: ["small": 15, "medium": 20, "large": 30],
               image: "peperonifresh",
               foodType: .pizza
           ),
           Pizza(
               id: 25,
               name: "Pesto",
               ingredients: [
                   Ingredient(id: 33, name: "Basil Pesto", isRemovable: false),
                   Ingredient(id: 2, name: "Mozzarella", isRemovable: true),
                   Ingredient(id: 1, name: "Tomatoes", isRemovable: false)
               ],
               ingredientsList: "Basil pesto, mozzarella, tomatoes",
               price: 20,
               prices: ["small": 15, "medium": 20, "large": 30],
               image: "pesto",
               foodType: .pizza
           ),
           Pizza(
               id: 26,
               name: "Vegan",
               ingredients: [
                   Ingredient(id: 34, name: "Plant-based Ingredients", isRemovable: false),
                   Ingredient(id: 35, name: "Vegan Cheese", isRemovable: true),
                   Ingredient(id: 6, name: "Signature Tomato Sauce", isRemovable: true)
               ],
               ingredientsList: "Plant-based ingredients, vegan cheese, signature tomato sauce",
               price: 20,
               prices: ["small": 15, "medium": 20, "large": 30],
               image: "vegan",
               foodType: .pizza
           )
    ]

    init (di: DependencyContainer) {
        self.di = di
    }
    
    let allFilters = [FoodType.romanPizza, FoodType.pizza, FoodType.combo, FoodType.snack, FoodType.breakfast, FoodType.milkshake, FoodType.drink, FoodType.coffee]
    
    let allStories = ["stories", "stories1", "stories2", "stories3", "stories", "stories1", "stories2", "stories3"]
    
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
