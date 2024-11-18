//
//  Extention + UILabel.swift
//  PizzaProject
//
//  Created by Artem Khlevchuk on 18.11.2024.
//

import UIKit

extension UILabel {
    func applyStrikethrought() {
        guard let text = self.text else { return }
        
        let attibutedString = NSAttributedString(
            string: text,
            attributes: [
                .strikethroughStyle: NSUnderlineStyle.single.rawValue,
                .strikethroughColor: self.textColor ?? UIColor.gray
            ])
        self.attributedText = attibutedString
    }
}

