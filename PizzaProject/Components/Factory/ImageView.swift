//
//  ImageView.swift
//  PizzaProject
//
//  Created by Artem Khlevchuk on 25.12.2024.
//

import UIKit

enum ImageViewStyle {
    case product
    case shortProduct
}

class ImageView: UIImageView {
    
    init(style: ImageViewStyle) {
        super.init(frame: .zero)
        
        commonInit(style)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit(_ style: ImageViewStyle) {
        switch style {
        case .product:
            image = UIImage(named: "pepperoni")
            contentMode = .scaleAspectFill
            let width = UIScreen.main.bounds.width
            heightAnchor.constraint(equalToConstant: 0.23 * width).isActive = true
            widthAnchor.constraint(equalToConstant: 0.23 * width).isActive = true
        case .shortProduct:
            image = UIImage(named: "pepperoni")
            contentMode = .scaleAspectFill
            let width = UIScreen.main.bounds.width
            heightAnchor.constraint(equalToConstant: 0.25 * width).isActive = true
            widthAnchor.constraint(equalToConstant: 0.25 * width).isActive = true
        }
    }
}
