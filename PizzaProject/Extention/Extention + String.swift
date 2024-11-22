//
//  Extention + String.swift
//  PizzaProject
//
//  Created by Artem Khlevchuk on 22.11.2024.
//

import UIKit

import UIKit

extension String {
    func withStrikethrough(style: NSUnderlineStyle = .single, color: UIColor = .black) -> NSAttributedString {
            let attributedText = NSMutableAttributedString(string: self)
            attributedText.addAttribute(.strikethroughStyle, value: style.rawValue, range: NSRange(location: 0, length: self.count))
            attributedText.addAttribute(.strikethroughColor, value: color, range: NSRange(location: 0, length: self.count))
            return attributedText
        }
    
    func withoutStrikethrough() -> NSAttributedString {
        return NSAttributedString(string: self)
    }
}
