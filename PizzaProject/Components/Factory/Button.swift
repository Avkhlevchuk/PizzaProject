//
//  Button.swift
//  PizzaProject
//
//  Created by Artem Khlevchuk on 25.12.2024.
//

import UIKit

enum ButtonStyle {
    case product
    case promo
}

class Button: UIButton {
    
    init(style: ButtonStyle) {
        super.init(frame: .zero)
        commonInit(style)
    }
    
    private  func commonInit(_ style: ButtonStyle){
        switch style {
        case .product:
            setTitleColor(.black, for: .normal)
            backgroundColor = .lightGray.withAlphaComponent(0.25)
            layer.cornerRadius = 12
            titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
            translatesAutoresizingMaskIntoConstraints = false
            contentEdgeInsets = UIEdgeInsets(top: 5, left: 6, bottom: 5, right: 6)
        case .promo:
            setTitleColor(.black, for: .normal)
            backgroundColor = .lightGray.withAlphaComponent(0.25)
            layer.cornerRadius = 12
            titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
            translatesAutoresizingMaskIntoConstraints = false
            contentEdgeInsets = UIEdgeInsets(top: 5, left: 20, bottom: 5, right: 20)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
