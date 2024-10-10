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
    
    lazy var tableView: UITableView = {
        let tableview = UITableView()
        tableview.backgroundColor = Colors.backgroundColor
        tableview.dataSource = self
        tableview.delegate = self
        tableview.rowHeight = 130
        tableview.estimatedRowHeight = 150
        tableview.separatorStyle = .none
        tableview.register(ProductCell.self , forCellReuseIdentifier: ProductCell.reuseId)
        return tableview
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupConstraints()
    }
        
    func setupViews() {
        view.backgroundColor = Colors.backgroundColor
        view.addSubview(tableView)
        view.addSubview(productContainer)
    }
    
    func setupConstraints() {
        
        productContainer.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.left.right.equalTo(view)
            make.height.equalTo(50)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(productContainer.snp.bottom)
            make.left.right.equalTo(view)
            make.bottom.equalTo(view)

        }
    }
    
}

//MARK: - TableViewDataSource, TableViewDelegate

extension ProductViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if  indexPath.section == 0 {
//            guard let cell = tableView.dequeueReusableCell(withIdentifier: ProductContainerCell.reuseId, for: indexPath) as? ProductContainerCell else { return UITableViewCell()}
//            
//            return cell
//        }
        
        if indexPath.row < 10 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ProductCell.reuseId, for: indexPath) as? ProductCell else { return UITableViewCell() }
            return cell
        }
        return UITableViewCell()
    }
}

