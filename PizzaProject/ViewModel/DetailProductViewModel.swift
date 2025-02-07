//
//  DetailProductViewModel.swift
//  PizzaProject
//
//  Created by Artem Khlevchuk on 01.11.2024.
//

import Foundation

protocol IDetailProductViewModel {
    
    var di: DependencyContainer { get set }
    
    var detailProductState: DetailProductViewModel.DetailProductState { get set }
    
    var product: Pizza { get set }
    
    var nutrition: [NutritionValue] { get set }
    
    var order: [Order]? { get set }
    
    var priceForPizza: Double { get set }
    
    var sizePizza: String { get set }
    
    var sumToppings: Double  { get set }
    
    var typeBasePizza: String { get set }
    
    var allToppings: [Toppings] { get set }
    
    var ingredientStatesInOrder: [IngredientStates] { get set }
    
    var onProductUpdate: (()-> ())? { get set }
    
    var toppingsInOrder: [Toppings] { get set }
    
    func getProduct() -> Pizza
    
    func getNutritionValue(id: Int) -> NutritionValue
    
    func updateProduct(_ product: Pizza)
    
    func calculateTotalPrice(topping: Toppings, priceForPizza: Double) -> Double
    
    func getTotalPrice() -> Double
    
    func addToCard()
    
    func editPosition()
    
    func resetRemovedIngredientStates()
    
    var saveRemovedIngredients: Bool { get set }
    
    var listSavedRemovedIngredients: [IngredientStates] { get set }
    
    func savedRemovedIngredients()
    
    func clearUnsavedIngredients()
    
    func createLineWithRemovedIngredients()
    
    var listRemovedIngredients: NSAttributedString? { get set }
    
    func updateSizeOfPizza(namePizzaSize: String)
    
    //MARK: - Setting for EditProductView
    func convertFromOrderToDataForDetailVM()
    
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
    
    var order: [Order]?
    
    lazy var priceForPizza: Double = Double(product.price)
    
    var sizePizza: String = "medium"
    
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
    
    //MARK: - RemoveIngredient block
    
    var ingredientStatesInOrder: [IngredientStates] = []
    
    var saveRemovedIngredients: Bool = false
    
    var listSavedRemovedIngredients: [IngredientStates] = []
    
    var onProductUpdate: (()-> ())?
    
    var toppingsInOrder = [Toppings]()
    
    let orderArchiver: OrderArchiver
    
    var listRemovedIngredients: NSAttributedString?
    
    enum DetailProductState {
        case createOrder
        case editOrder
    }
    
    var detailProductState: DetailProductState
    
    var di: DependencyContainer
    
    init (product: Pizza, di: DependencyContainer, detailProductState: DetailProductState, order: [Order]) {
        self.di = di
        self.product = product
        orderArchiver = di.orderArchiver
        self.detailProductState = detailProductState
        self.order = order
        
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
    
    func updateSizeOfPizza(namePizzaSize: String) {
        sizePizza = namePizzaSize
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
        
        toppingsInOrder = toppingsInOrder.sorted(by: <)
        
        let roundedSum = (sumToppings * 10).rounded() / 10
        
        let totalPrice = Double(priceForPizza) + roundedSum
        
        return totalPrice
    }
    
    func getTotalPrice() -> Double {
        return priceForPizza + sumToppings
    }
    
    func addToCard() {
        
        var currentOrder = di.orderArchiver.load()
        
        var orderId = 0
        
        if !currentOrder.isEmpty {
            orderId = currentOrder.count + 1
        }
        
        let order = Order(orderId: orderId, product: product, count: 1, removedIngredients: ingredientStatesInOrder, toppings: toppingsInOrder, sumForToppings: sumToppings, priceForPizza: priceForPizza, sizePizza: sizePizza, typeBasePizza: typeBasePizza)
        
        if currentOrder.isEmpty {
            di.orderArchiver.save(order: [order])
        }else {
            
            if let index = checkPositionInOrder(orders: currentOrder, newPosition: order) {
                currentOrder[index].count += 1
                di.orderArchiver.addCountPosition(index: index)
                return
            }
            
            di.orderArchiver.addPosition(order: order)
        }
    }
    
    func checkPositionInOrder(orders: [Order], newPosition: Order ) -> Int? {
        return orders.firstIndex { $0 == newPosition }
    }
    
    func editPosition() {
        let orderId = order?[0].orderId ?? 1
        let countItem = order?[0].count ?? 1
        
        var currentOrder = di.orderArchiver.load()
        
        let updatedOrder = Order(orderId: orderId, product: product, count: countItem, removedIngredients: ingredientStatesInOrder, toppings: toppingsInOrder, sumForToppings: sumToppings, priceForPizza: priceForPizza, sizePizza: sizePizza, typeBasePizza: typeBasePizza)
        
        guard let index = currentOrder.firstIndex(where: { $0.orderId == orderId }) else {
            print("Order with id \(orderId) not found")
            return
        }
        
        currentOrder[index] = updatedOrder
        
        di.orderArchiver.save(order: currentOrder)
    }
    
    func resetRemovedIngredientStates() {
        for index in ingredientStatesInOrder.indices {
            ingredientStatesInOrder[index].isRemoved = false
        }
    }
    
    func savedRemovedIngredients() {
        listSavedRemovedIngredients = ingredientStatesInOrder
    }
    
    func clearUnsavedIngredients() {
        ingredientStatesInOrder = listSavedRemovedIngredients
    }
    
    func createLineWithRemovedIngredients() {
        
        let listIngredients = NSMutableAttributedString()
        
        var index = 0
        
        while index < ingredientStatesInOrder.count {
            let current = ingredientStatesInOrder[index]
            var newIngredient: String = ingredientStatesInOrder[index].ingredient.name
            let comma = ","
            
            switch index {
            case 0:
                newIngredient += comma
            case ingredientStatesInOrder.count - 1:
                newIngredient = newIngredient.lowercased()
            default:
                newIngredient = newIngredient.lowercased()
                newIngredient += comma
            }
            
            let attributedIngredient: NSAttributedString
            if current.isRemoved {
                attributedIngredient = newIngredient.withStrikethrough(style: .single, color: .black)
                listIngredients.append(attributedIngredient)
            } else {
                attributedIngredient = NSAttributedString(string: newIngredient)
                listIngredients.append(attributedIngredient)
            }
            
            listIngredients.append(NSAttributedString(string: " "))
            
            index += 1
            
            listRemovedIngredients = listIngredients
        }
    }
}

//MARK: - Setting for EditProductView
extension DetailProductViewModel {
    func convertFromOrderToDataForDetailVM() {
        
        guard let selectedOrder = order?[0] else { return }
        //SelectedSegmentControl
        sizePizza = selectedOrder.sizePizza
        typeBasePizza = selectedOrder.typeBasePizza
        
        //Sync for remove ingredients block
        ingredientStatesInOrder = selectedOrder.removedIngredients
        listSavedRemovedIngredients = selectedOrder.removedIngredients
        createLineWithRemovedIngredients()
        saveRemovedIngredients = true
        //Sync for toppings
        toppingsInOrder =  selectedOrder.toppings
        sumToppings = selectedOrder.sumForToppings
        priceForPizza = selectedOrder.priceForPizza
    }
}
