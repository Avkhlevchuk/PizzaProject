//
//  RemoveIngredientsViewController.swift
//  PizzaProject
//
//  Created by Artem Khlevchuk on 18.11.2024.
//

import UIKit
import SnapKit

class RemoveIngredientsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
        
    private var detailProductViewModel: IDetailProductViewModel
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.showsHorizontalScrollIndicator = false
        tableView.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerCell(RemoveContainerIngredientsCell.self)
        return tableView
    }()
    
    init(detailProductViewModel: IDetailProductViewModel ) {
        self.detailProductViewModel = detailProductViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    
    }
    
    func setupViews() {
        view.addSubview(tableView)
        view.backgroundColor = .white
    }
    
    func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(indexPath) as RemoveContainerIngredientsCell
        cell.bind(ingredients: detailProductViewModel.product.ingredients)
        
        cell.onSelectItemTapped = { [weak self] ingredientStates in
            self?.detailProductViewModel.ingretientStatesInOrder = ingredientStates
        }
        return cell
    }
}
