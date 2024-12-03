//
//  Collection + isNotEmpty.swift
//  PizzaProject
//
//  Created by Artem Khlevchuk on 03.12.2024.
//

import UIKit

extension Collection {
    var isNotEmpty: Bool { !isEmpty }
}

extension Optional where Wrapped: Collection {
    var isNotEmpty: Bool {
        switch self {
        case .none:
            return false
        case .some(let collection):
            return collection.isNotEmpty
        }
    }
}
