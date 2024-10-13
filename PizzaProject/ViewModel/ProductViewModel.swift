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
        Pizza(id: 1, name: "Сырная", ingredients: "Моцарелла, сыры чеддер и пармезан, фирменный соус альфредо", price: 279, image: "margarita", foodType: .pizza),
        Pizza(id: 2, name: "Пепперони фреш", ingredients: "Пикантная пепперони, увеличенная порция моцареллы, томаты, фирменный томатный соус", price: 329, image: "pepperoni", foodType: .pizza),
        Pizza(id: 3, name: "Двойной цыпленок", ingredients: "Цыпленок, моцарелла, фирменный соус альфредо", price: 429, image: "hawaii", foodType: .pizza),
        Pizza(id: 4, name: "Ветчина и сыр", ingredients: "Ветчина, моцарелла, фирменный соус альфредо", price: 349, image: "margarita", foodType: .pizza),
        Pizza(id: 5, name: "Тройная пеперони", ingredients: "Пикантная пепперони, увеличенная порция моцареллы, томаты, фирменный томатный соус", price: 777, image: "default", foodType: .pizza)
    ]
    
    let allFilters = [FoodType.romanPizza, FoodType.pizza, FoodType.combo, FoodType.snack, FoodType.breakfast]
    
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
