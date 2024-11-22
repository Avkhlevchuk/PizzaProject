//
//  Extention + UILabel.swift
//  PizzaProject
//
//  Created by Artem Khlevchuk on 18.11.2024.
//

import UIKit

extension UILabel {    
    func applyStrikethrought(_ strikethroughStyle: NSUnderlineStyle, strikethroughColor: UIColor = .clear) {
           guard let labelText = text else { return }
           
           let attributedText = NSMutableAttributedString(string: labelText)

           attributedText.addAttribute(NSAttributedString.Key.strikethroughStyle, value: strikethroughStyle.rawValue, range: NSMakeRange(0, attributedText.length))
           attributedText.addAttribute(NSAttributedString.Key.strikethroughColor, value: strikethroughColor, range: NSMakeRange(0, attributedText.length))
           self.attributedText = attributedText
       }
    
    func removeStrikeThrought() {
        guard let attributedText = self.attributedText else { return }
        
        self.attributedText = nil
        self.text = attributedText.string
    }
    
}

