//
//  UICollectionView + dequeueCell.swift
//  PizzaProject
//
//  Created by Artem Khlevchuk on 17.11.2024.
//

import UIKit

extension UICollectionView {
    
    func registerCell<Cell: UICollectionViewCell>(_ cellClass: Cell.Type) {
        register(cellClass, forCellWithReuseIdentifier: cellClass.reuseId)
    }
    
    func dequeueCell<Cell: UICollectionViewCell>(_ indexPath: IndexPath) -> Cell {
        guard let cell = self.dequeueReusableCell(withReuseIdentifier: Cell.reuseId, for: indexPath) as? Cell else { fatalError("Fatal error for cell as \(indexPath)") }
        return cell
    }
}
