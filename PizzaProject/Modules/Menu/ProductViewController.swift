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
    private var productViewModel: IProductViewModel
    let productShortContainer = ShortProductContainerCell()
    let cartView = CartView()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = Colors.backgroundColor
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.registerCell(ProductCell.self)
        tableView.registerCell(ProductContainerCell.self)
        tableView.registerCell(ShortProductContainerCell.self)
        tableView.registerCell(StoryContainerCell.self)
        
        return tableView
    }()
    
    init(productViewModel: IProductViewModel) {
        self.productViewModel = productViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
        setupBinding()
        
        productViewModel.fetchProducts()
        productViewModel.getCartTotal()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        productViewModel.getCartTotal()
        tableView.reloadData()
    }
    
    @objc private func dismissVC() {
           dismiss(animated: true)
       }
    
    func setupViews() {
        view.backgroundColor = Colors.backgroundColor
        [tableView, cartView].forEach {
            view.addSubview($0)
        }
    }
    
    func setupConstraints() {
        
        cartView.snp.makeConstraints { make in
            make.right.equalTo(view.snp.right).inset(20)
            make.bottom.equalTo(view.snp.bottom).inset(40)
            make.height.equalTo(60)
            make.width.greaterThanOrEqualTo(100)
        }
        
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
        
        }
        
        productViewModel.onCartUpdate = { [weak self] totalPrice in
            guard let self = self else { return }
            self.cartView.bind(totalPrice: totalPrice)
        }
        
        cartView.onCartButtonTapped = { [weak self] in
            
            if let comtainerDI = self?.productViewModel.di {
                let cardViewModel = CartViewModel()
                let vc = comtainerDI.screenFactory.createCartScreen(cartViewModel: cardViewModel)
                
                self?.present(vc, animated: true)
            }
        }
    }
}

//MARK: - TableViewDataSource, TableViewDelegate

extension ProductViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        case 2:
            return 1
        case 3:
            return productViewModel.products.count
        default :
            return 0
            
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueCell(indexPath) as StoryContainerCell
            return cell
        case 1:
            let cell = tableView.dequeueCell(indexPath) as ShortProductContainerCell
            
            let product = productViewModel.products
            cell.bind(product: product)
            return cell
            
        case 2:
            let cell = tableView.dequeueCell(indexPath) as ProductContainerCell
            
            cell.onFilterButtonTapped = { [weak self] in
                guard let self = self else { return }
                self.productContainer.onFilterButtonTapped?()
            }
            
            let filter = productViewModel.allFilters
            cell.update(filter)
            return cell
        case 3:
            let cell = tableView.dequeueCell(indexPath) as ProductCell
            let product = productViewModel.products[indexPath.row]
            cell.update(product)
            return cell
            
        default:
            return UITableViewCell()
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedProduct = productViewModel.products[indexPath.row]
        
        if let cobainerDI = productViewModel.di {
            let detailVC = cobainerDI.screenFactory.createDetailProductScreen(product: selectedProduct)
            detailVC.modalPresentationStyle = .fullScreen
            
            present(detailVC, animated: true)
        }        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
