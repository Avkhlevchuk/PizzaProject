//
//  StackView.swift
//  PizzaProject
//
//  Created by Artem Khlevchuk on 27.12.2024.
//

import UIKit

enum StackViewStyle {
    case vertical
}

class StackView: UIStackView {
    
    init(style: StackViewStyle) {
        super.init(frame: .zero)
        
        commonInit(style)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit(_ style: StackViewStyle) {
        
        switch style {
        case .vertical:
            axis = .vertical
            alignment = .leading
            spacing = 10
        }
    }
}
