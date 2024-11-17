//
//  UICollectionViewCell + reuseId.swift
//  PizzaProject
//
//  Created by Artem Khlevchuk on 17.11.2024.
//

import UIKit

extension UICollectionViewCell: Reusable{}

extension Reusable where Self: UICollectionViewCell {
  
  static var reuseId: String {
    String(describing: self)
  }
}

