//
//  DependencyContainer.swift
//  PizzaProject
//
//  Created by Artem Khlevchuk on 08.11.2024.
//

import UIKit

final class DependencyContainer {
    let screenFactory: ScreenFactory
    let orderArchiver: OrderArchiver
    private let encoder: JSONEncoder
    private let decoder: JSONDecoder
    let productLoader: ProductLoader
    
    init() {
        screenFactory = ScreenFactory()
        encoder = JSONEncoder()
        decoder = JSONDecoder()
        orderArchiver = OrderArchiver(encoder: encoder, decoder: decoder)
        productLoader = ProductLoader()
        screenFactory.di = self
    }
}

final class ScreenFactory {
    
    var di: DependencyContainer!
    
    func createProductScreen() -> ProductViewController {
        let productViewModel = ProductViewModel(di: di)
        return ProductViewController(productViewModel: productViewModel)
    }
    
    func createProductDisplayScreen(productViewModel: IProductViewModel) -> ProductDisplayViewController {
//        let productViewModel = ProductViewModel(di: di)
        return ProductDisplayViewController(productViewModel: productViewModel)
    }
    
    func createDetailProductScreen(product: Pizza) -> DetailViewController {
        let detailProductViewModel = DetailProductViewModel(product: product, di: di, detailProductState: .createOrder, order: [])
        return DetailViewController(detailProductViewModel: detailProductViewModel)
    }
    
    func editOrderDetailProductScreen(product: Pizza, order: [Order]) -> DetailViewController {
        let detailProductViewModel = DetailProductViewModel(product: product, di: di, detailProductState: .editOrder, order: order)
        return DetailViewController(detailProductViewModel: detailProductViewModel)
    }
    
    func createRemoveIngredientsScreen(detailProductViewModel: IDetailProductViewModel ) -> RemoveIngredientsViewController {
        return RemoveIngredientsViewController(detailProductViewModel: detailProductViewModel)
    }
    
    func createCartScreen() -> CartViewController {
        let cartScreenViewModel = CartViewModel(di: di)
        return CartViewController(cartViewModel: cartScreenViewModel)
    }
}
