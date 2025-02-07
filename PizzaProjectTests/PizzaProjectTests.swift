import XCTest
@testable import PizzaProject

final class PizzaProjectTests: XCTestCase {
    //MARK: - DetailProductViewModel
    func testCalculationTotalPrice() {
        //Given
        let topping = Toppings(id: 1, name: "pepeponi", price: 2.0)
        let priceForPizza = 20.0
        let product = Pizza(id: 1, name: "pepeponi", isPromo: false, ingredients: [Ingredient(id: 1, name: "cheese", isRemovable: false)], ingredientsList: "", price: 20, prices: ["Small": 20], image: "peperoni", foodType: "Pizza")
        let di = DependencyContainer()
        let detailProductVM = DetailProductViewModel(product: product, di: di, detailProductState: .createOrder, order: [])
        
        //When
        let totalPrice = detailProductVM.calculateTotalPrice(topping: topping, priceForPizza: priceForPizza)
        
        //Then
        XCTAssertEqual(totalPrice, 22.0)
    }
    
    func testCheckPositionInOrder() {
        //Given
        let product = Pizza(id: 1, name: "pepeponi", isPromo: false, ingredients: [Ingredient(id: 1, name: "cheese", isRemovable: false)], ingredientsList: "", price: 20, prices: ["Small": 20], image: "peperoni", foodType: "Pizza")
        
        let position = [Order(orderId: 5, product: PizzaProject.Pizza(id: 3, name: "Mexico Burger", isPromo: false, ingredients: [PizzaProject.Ingredient(id: 7, name: "Beef", isRemovable: false), PizzaProject.Ingredient(id: 10, name: "Pickles", isRemovable: true), PizzaProject.Ingredient(id: 4, name: "Onions", isRemovable: true), PizzaProject.Ingredient(id: 11, name: "Cheddar", isRemovable: false), PizzaProject.Ingredient(id: 2, name: "Mozzarella", isRemovable: true), PizzaProject.Ingredient(id: 12, name: "Burger Sauce", isRemovable: false)], ingredientsList: "Beef, pickles, onions, cheddar, mozzarella, burger sauce", price: 25, prices: ["medium": 25, "small": 15, "large": 30], image: "burger", foodType: "Roman Pizza"), count: 1, removedIngredients: [], toppings: [], sumForToppings: 0.0, priceForPizza: 25.0, sizePizza: "small", typeBasePizza: "thin"),
                        
                        Order(orderId: 5, product: PizzaProject.Pizza(id: 3, name: "Burger", isPromo: false, ingredients: [PizzaProject.Ingredient(id: 7, name: "Beef", isRemovable: false), PizzaProject.Ingredient(id: 10, name: "Pickles", isRemovable: true), PizzaProject.Ingredient(id: 4, name: "Onions", isRemovable: true), PizzaProject.Ingredient(id: 11, name: "Cheddar", isRemovable: false), PizzaProject.Ingredient(id: 2, name: "Mozzarella", isRemovable: true), PizzaProject.Ingredient(id: 12, name: "Burger Sauce", isRemovable: false)], ingredientsList: "Beef, pickles, onions, cheddar, mozzarella, burger sauce", price: 25, prices: ["medium": 25, "small": 15, "large": 30], image: "burger", foodType: "Roman Pizza"), count: 1, removedIngredients: [], toppings: [], sumForToppings: 0.0, priceForPizza: 25.0, sizePizza: "medium", typeBasePizza: "thin")]
        
        let newPosition = Order(orderId: 5, product: PizzaProject.Pizza(id: 3, name: "Burger", isPromo: false, ingredients: [PizzaProject.Ingredient(id: 7, name: "Beef", isRemovable: false), PizzaProject.Ingredient(id: 10, name: "Pickles", isRemovable: true), PizzaProject.Ingredient(id: 4, name: "Onions", isRemovable: true), PizzaProject.Ingredient(id: 11, name: "Cheddar", isRemovable: false), PizzaProject.Ingredient(id: 2, name: "Mozzarella", isRemovable: true), PizzaProject.Ingredient(id: 12, name: "Burger Sauce", isRemovable: false)], ingredientsList: "Beef, pickles, onions, cheddar, mozzarella, burger sauce", price: 25, prices: ["medium": 25, "small": 15, "large": 30], image: "burger", foodType: "Roman Pizza"), count: 1, removedIngredients: [], toppings: [], sumForToppings: 0.0, priceForPizza: 25.0, sizePizza: "medium", typeBasePizza: "thin")
        
        let di = DependencyContainer()
        let detailProductVM = DetailProductViewModel(product: product, di: di, detailProductState: .createOrder, order: [])
        //When
        let equal = detailProductVM.checkPositionInOrder(orders: position, newPosition: newPosition)
        //Then
        XCTAssertEqual(equal, 1)
    }
    
//MARK: - ProductViewModel
    
    func testGetCartTotal() {
        //Given
        let di = DependencyContainer()
        
        let position = Order(orderId: 5, product: PizzaProject.Pizza(id: 3, name: "Burger", isPromo: false, ingredients: [PizzaProject.Ingredient(id: 7, name: "Beef", isRemovable: false), PizzaProject.Ingredient(id: 10, name: "Pickles", isRemovable: true), PizzaProject.Ingredient(id: 4, name: "Onions", isRemovable: true), PizzaProject.Ingredient(id: 11, name: "Cheddar", isRemovable: false), PizzaProject.Ingredient(id: 2, name: "Mozzarella", isRemovable: true), PizzaProject.Ingredient(id: 12, name: "Burger Sauce", isRemovable: false)], ingredientsList: "Beef, pickles, onions, cheddar, mozzarella, burger sauce", price: 25, prices: ["medium": 25, "small": 15, "large": 30], image: "burger", foodType: "Roman Pizza"), count: 1, removedIngredients: [], toppings: [], sumForToppings: 0.0, priceForPizza: 25.0, sizePizza: "medium", typeBasePizza: "thin")
        
        let order = Array(repeating: position, count: 4)
        
        di.orderArchiver.save(order: order)
        
        let productViewModel = ProductViewModel(di: di)
    
        //When
        productViewModel.getCartTotal()
        let totalPrice = productViewModel.totalPriceCart
        
        //Then
        
        XCTAssertEqual(totalPrice, 100.0)
        
    }
    
}
