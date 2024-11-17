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
        Pizza(id: 1, name: "Arriva", ingredients: "Tomatoes, mozzarella, pepperoni, onions, bell peppers, signature tomato sauce", price: 25, prices: ["small": 15, "medium": 25, "large": 30], image: "arriva", foodType: .pizza),
        Pizza(id: 2, name: "Bestroganov", ingredients: "Beef, mushrooms, onions, mozzarella, stroganoff sauce", price: 25, prices: ["small": 15, "medium": 25, "large": 30], image: "bestroganov", foodType: .pizza),
        Pizza(id: 3, name: "Burger", ingredients: "Beef, pickles, onions, cheddar, mozzarella, burger sauce", price: 25, prices: ["small": 15, "medium": 25, "large": 30], image: "burger", foodType: .pizza),
        Pizza(id: 4, name: "Cheese Chicken", ingredients: "Chicken, mozzarella, cheddar, signature Alfredo sauce", price: 20, prices: ["small": 15, "medium": 20, "large": 30], image: "cheesechicken", foodType: .pizza),
        Pizza(id: 5, name: "Cheese Pizza", ingredients: "Mozzarella, cheddar, signature Alfredo sauce", price: 15, prices: ["small": 10, "medium": 15, "large": 25], image: "cheesePizza", foodType: .pizza),
        Pizza(id: 6, name: "Chicken Barbeku", ingredients: "Chicken, barbecue sauce, mozzarella, onions", price: 20, prices: ["small": 15, "medium": 20, "large": 30], image: "chickenbarbeku", foodType: .pizza),
        Pizza(id: 7, name: "Chicken Ranch", ingredients: "Chicken, mozzarella, ranch sauce, tomatoes", price: 20, prices: ["small": 15, "medium": 20, "large": 30], image: "chickenranch", foodType: .pizza),
        Pizza(id: 8, name: "Chorizo", ingredients: "Chorizo, mozzarella, signature tomato sauce", price: 20, prices: ["small": 15, "medium": 20, "large": 30], image: "chorizo", foodType: .pizza),
        Pizza(id: 9, name: "Diablo", ingredients: "Pepperoni, jalapeños, mozzarella, spicy tomato sauce", price: 20, prices: ["small": 15, "medium": 20, "large": 30], image: "diablo", foodType: .pizza),
        Pizza(id: 10, name: "Mexico", ingredients: "Pepperoni, bell peppers, mushrooms, olives, mozzarella, signature tomato sauce", price: 25, prices: ["small": 15, "medium": 25, "large": 30], image: "dodo", foodType: .pizza),
        Pizza(id: 11, name: "Mexico Mix", ingredients: "Mixed toppings, mozzarella, signature tomato sauce", price: 25, prices: ["small": 15, "medium": 25, "large": 30], image: "dodomix", foodType: .pizza),
        Pizza(id: 12, name: "Double Pepperoni", ingredients: "Double portion of pepperoni, mozzarella, signature tomato sauce", price: 20, prices: ["small": 15, "medium": 20, "large": 30], image: "doublepeperoni", foodType: .pizza),
        Pizza(id: 13, name: "Four Season", ingredients: "Four sections with different toppings, mozzarella, signature tomato sauce", price: 25, prices: ["small": 15, "medium": 25, "large": 30], image: "fourseason", foodType: .pizza),
        Pizza(id: 14, name: "Ham & Cheese", ingredients: "Ham, mozzarella, signature Alfredo sauce", price: 20, prices: ["small": 15, "medium": 20, "large": 30], image: "ham&cheese", foodType: .pizza),
        Pizza(id: 15, name: "Ham & Mash", ingredients: "Ham, mashed potatoes, mozzarella, signature Alfredo sauce", price: 20, prices: ["small": 15, "medium": 20, "large": 30], image: "ham&mash", foodType: .pizza),
        Pizza(id: 16, name: "Hawaii", ingredients: "Ham, pineapple, mozzarella, signature tomato sauce", price: 20, prices: ["small": 15, "medium": 20, "large": 30], image: "hawaii", foodType: .pizza),
        Pizza(id: 17, name: "Julien", ingredients: "Mushrooms, mozzarella, creamy sauce", price: 15, prices: ["small": 10, "medium": 15, "large": 25], image: "julien", foodType: .pizza),
        Pizza(id: 18, name: "Karbonara", ingredients: "Bacon, egg, mozzarella, Alfredo sauce", price: 20, prices: ["small": 15, "medium": 20, "large": 30], image: "karbonara", foodType: .pizza),
        Pizza(id: 19, name: "Krevetka", ingredients: "Shrimp, tomatoes, mozzarella, garlic sauce", price: 25, prices: ["small": 15, "medium": 25, "large": 30], image: "krevetka", foodType: .pizza),
        Pizza(id: 20, name: "Margarita", ingredients: "Tomatoes, mozzarella, signature tomato sauce", price: 15, prices: ["small": 10, "medium": 15, "large": 25], image: "margarita", foodType: .pizza),
        Pizza(id: 21, name: "Meat", ingredients: "Various meats, mozzarella, signature tomato sauce", price: 25, prices: ["small": 15, "medium": 25, "large": 30], image: "meat", foodType: .pizza),
        Pizza(id: 22, name: "Meat with Souse", ingredients: "Various meats, mozzarella, special sauce", price: 25, prices: ["small": 15, "medium": 25, "large": 30], image: "meatwithsouse", foodType: .pizza),
        Pizza(id: 23, name: "Pepperoni", ingredients: "Pepperoni, mozzarella, signature tomato sauce", price: 20, prices: ["small": 15, "medium": 20, "large": 30], image: "peperoni", foodType: .pizza),
        Pizza(id: 24, name: "Pepperoni Fresh", ingredients: "Pepperoni, tomatoes, mozzarella, signature tomato sauce", price: 20, prices: ["small": 15, "medium": 20, "large": 30], image: "peperonifresh", foodType: .pizza),
        Pizza(id: 25, name: "Pesto", ingredients: "Basil pesto, mozzarella, tomatoes", price: 20, prices: ["small": 15, "medium": 20, "large": 30], image: "pesto", foodType: .pizza),
        Pizza(id: 26, name: "Vegan", ingredients: "Plant-based ingredients, vegan cheese, tomato sauce", price: 20, prices: ["small": 15, "medium": 20, "large": 30], image: "vegan", foodType: .pizza)
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
