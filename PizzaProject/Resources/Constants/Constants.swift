//
//  Constants.swift
//  PizzaProject
//
//  Created by Artem Khlevchuk on 09.11.2024.
//

import UIKit

struct ScreenSize {
    static let width = UIScreen.main.bounds.width
}

enum PizzaSize: String {
    case small = "25 cm"
    case medium = "30 cm"
    case large = "35 cm"
}

enum PizzaBaseType: String {
    case traditional = "Traditional"
    case thin = "Thin"
}
