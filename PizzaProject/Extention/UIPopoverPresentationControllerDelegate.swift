//
//  UIPopoverPresentationControllerDelegate.swift
//  PizzaProject
//
//  Created by Artem Khlevchuk on 17.11.2024.
//

import UIKit

extension DetailViewController: UIPopoverPresentationControllerDelegate {
    
    func adaptivePresentationStyle(
        for controller: UIPresentationController,
        traitCollection: UITraitCollection
    ) -> UIModalPresentationStyle {
        // Return no adaptive presentation style,
        // use default presentation behaviour
        return .none
    }
}
