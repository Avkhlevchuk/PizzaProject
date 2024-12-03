//
//  RequestError.swift
//  PizzaProject
//
//  Created by Artem Khlevchuk on 08.11.2024.
//

import UIKit

enum RequestError: Error {
    case decode
    case invalidURL
    case noResponse
    case unauthorized
    case unexpectedStatusCode
    case unknown
    
    var customMessage: String {
        switch self {
        case .decode:
            return "Decode error"
        case .unauthorized:
            return "Unauthorized"
        default:
            return "Unknow error"
        }
    }
}
