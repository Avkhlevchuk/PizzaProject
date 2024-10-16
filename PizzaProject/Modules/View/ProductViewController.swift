//
//  ViewController.swift
//  PizzaProject
//
//  Created by Artem Khlevchuk on 15.09.2024.
//

import UIKit
import SnapKit

class ProductViewController: UIViewController {
    let productContainer = ProductContainerCell()
    let productViewModel = ProductViewModel()
    let productShortContainer = ShortProductContainerCell()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = Colors.backgroundColor
        tableView.dataSource = self
        tableView.delegate = self
//        tableView.estimatedRowHeight = 150
        tableView.separatorStyle = .none
        tableView.register(ProductCell.self , forCellReuseIdentifier: ProductCell.reuseId)
        tableView.register(ProductContainerCell.self , forCellReuseIdentifier: ProductContainerCell.reuseId)
        tableView.register(ShortProductContainerCell.self , forCellReuseIdentifier: ShortProductContainerCell.reuseId)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupConstraints()
        setupBinding()
        
        productViewModel.fetchProducts()
        
    }
        
    func setupViews() {
        view.backgroundColor = Colors.backgroundColor
        view.addSubview(tableView)
    }
    
    func setupConstraints() {
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.left.right.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide)

        }
    }
    
    func setupBinding() {
        productContainer.onFilterButtonTapped = {
            print("taped button in collection")
        }
        
        productViewModel.onProductUpdate = { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
}

//MARK: - TableViewDataSource, TableViewDelegate

extension ProductViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
            case 0:
                return 1
            case 1:
                return 1
            case 2:
                return productViewModel.products.count
            default :
                return 0
        
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
                case 0:
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ShortProductContainerCell.reuseId, for: indexPath) as? ShortProductContainerCell else { return UITableViewCell() }
            return cell
            
                case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ProductContainerCell.reuseId, for: indexPath) as? ProductContainerCell else { return UITableViewCell() }
            
            cell.onFilterButtonTapped = { [weak self] in
                guard let self = self else { return }
                self.productContainer.onFilterButtonTapped?()
            }
            
            let filter = productViewModel.allFilters
            cell.update(filter)
            return cell
                case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ProductCell.reuseId, for: indexPath) as? ProductCell else { return UITableViewCell() }
            let product = productViewModel.products[indexPath.row]
            cell.update(product)
            return cell
            
        default:
            return UITableViewCell()
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("taped on cell")
    }
}
