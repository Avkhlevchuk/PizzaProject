//
//  UITableView + dequeueCell.swift
//  PizzaProject
//
//  Created by Artem Khlevchuk on 17.11.2024.
//

import UIKit

extension UITableView {
    func registerCell<Cell:UITableViewCell>(_ cellClass: Cell.Type) {
        register(cellClass, forCellReuseIdentifier: cellClass.reuseId)
    }
    
    func dequeueCell<Cell:UITableViewCell>(_ indexPath: IndexPath) -> Cell {
        guard let cell = self.dequeueReusableCell(withIdentifier: Cell.reuseId, for: indexPath) as? Cell else { fatalError("Fatal error for cell as \(indexPath)") }
        return cell
    }
    
}
