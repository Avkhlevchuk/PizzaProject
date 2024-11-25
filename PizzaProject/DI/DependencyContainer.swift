//
//  DependencyContainer.swift
//  PizzaProject
//
//  Created by Artem Khlevchuk on 08.11.2024.
//

import UIKit

final class DependencyContainer {
    let screenFactory: ScreenFactory
    
    init() {
        screenFactory = ScreenFactory()
        screenFactory.di = self
    }
}

final class ScreenFactory {
    
    var di: DependencyContainer!
    
    func createProductScreen() -> ProductViewController {
        let productViewModel = ProductViewModel(di: di)
        return ProductViewController(productViewModel: productViewModel)
    }
    
    func createDetailProductScreen(product: Pizza) -> DetailViewController {
        let detailProductViewModel = DetailProductViewModel(product: product)
        return DetailViewController(detailProductViewModel: detailProductViewModel, di: di)
    }
    
    func createRemoveIngredientsScreen(detailProductViewModel: IDetailProductViewModel ) -> RemoveIngredientsViewController {
        return RemoveIngredientsViewController(detailProductViewModel: detailProductViewModel)
    }
    
    func createCartScreen(cartViewModel: ICartViewModel) -> CartViewController {
        return CartViewController(cartViewModel: cartViewModel)
    }
}
