//
//  UIViewBlur.swift
//  PizzaProject
//
//  Created by Artem Khlevchuk on 05.11.2024.
//

import UIKit

public extension UIView {

    @discardableResult
    func addBlur(style: UIBlurEffect.Style = .light, alpha: CGFloat) -> UIVisualEffectView {
        let blurEffect = UIBlurEffect(style: style)
        let blurBackground = UIVisualEffectView(effect: blurEffect)
        addSubview(blurBackground)
        blurBackground.translatesAutoresizingMaskIntoConstraints = false
        blurBackground.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        blurBackground.topAnchor.constraint(equalTo: topAnchor).isActive = true
        blurBackground.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        blurBackground.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        blurBackground.alpha = alpha
        return blurBackground
    }
}
