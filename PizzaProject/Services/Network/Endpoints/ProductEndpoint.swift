//
//  ProductEndpoint.swift
//  PizzaProject
//
//  Created by Artem Khlevchuk on 08.11.2024.
//

import UIKit

enum ProductEndpoint {
    case product
    case filter
    case story
}

extension ProductEndpoint: Endpoint {
    var path: String {
        switch self {
        case .product:
            return "/products"
        case .filter:
            return "/filters"
        case .story:
            return "/stories"
        }
    }
    
    var method: RequestMethod {
        switch self {
        case .product, .filter, .story:
            return .get
        
        }
    }
    
    var header: [String : String]? {    
        switch self {
        case .product, .filter, .story:
            return [
                "Content-Type": "application/json;charset=utf-8"
            ]
        }
    }
    
    var body: [String : String]? {
        switch self {
        case .product, .filter, .story:
            return nil
        }
    }
    
    
}
