//
//  ProductEndpoint.swift
//  PizzaProject
//
//  Created by Artem Khlevchuk on 08.11.2024.
//

import UIKit

enum ProductEndpoint {
    case product
}

extension ProductEndpoint: Endpoint {
    var path: String {
        switch self {
        case .product:
            return "/products"
        }
    }
    
    var method: RequestMethod {
        switch self {
        case .product:
            return .get
        }
    }
    
    var header: [String : String]? {    
        switch self {
        case .product:
            return [
                "Content-Type": "application/json;charset=utf-8"
            ]
        }
    }
    
    var body: [String : String]? {
        switch self {
        case .product:
            return nil
        }
    }
    
    
}
