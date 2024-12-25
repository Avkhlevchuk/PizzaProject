//
//  Label.swift
//  PizzaProject
//
//  Created by Artem Khlevchuk on 25.12.2024.
//

import UIKit

enum LabelStyle {
    case promoTitle
    case promoDescription
    case title
    case description
}

class Label: UILabel {
    
    init(style: LabelStyle, text: String = "") {
        super.init(frame: .zero)
        
        commonInit(style, text)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit(_ type: LabelStyle, _ text: String = "") {
        
        switch type {
        case .promoTitle:
            textColor = .black
            font = .boldSystemFont(ofSize: 15)
            textAlignment = .left
            numberOfLines = 0
        case .promoDescription:
            textColor = .gray
            font = .systemFont(ofSize: 12)
            textAlignment = .left
            numberOfLines = 0
        case .title:
            textColor = .black
            font = UIFont.boldSystemFont(ofSize: 14)
            textAlignment = .left
        case .description:
            textColor = .black
            numberOfLines = 0
            font = UIFont.systemFont(ofSize: 12)
        }
    }
}
