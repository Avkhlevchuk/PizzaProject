//
//  ViewController.swift
//  PizzaProject
//
//  Created by Artem Khlevchuk on 15.09.2024.
//

import UIKit
import SnapKit

class ProductViewController: UIViewController {
    let productContainer = ProductContainerHeader()
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
//        tableView.registerCell(ProductContainerCell.self)
        tableView.registerCell(ShortProductContainerCell.self)
        tableView.register(ProductContainerHeader.self, forHeaderFooterViewReuseIdentifier: ProductContainerHeader.reuseId)
        tableView.registerCell(StoryContainerCell.self)
        tableView.estimatedSectionHeaderHeight = 40
        
        if #available(iOS 15.0, *) {
          tableView.sectionHeaderTopPadding = 0.0
        }
        
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
        
        productViewModel.getProducts()
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
            make.bottom.equalTo(view)
        }
    }
    
    func setupBinding() {
        
        productViewModel.onProductUpdate = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        
        productViewModel.onCartUpdate = { [weak self] totalPrice in
            guard let self = self else { return }
            self.cartView.bind(totalPrice: totalPrice)
        }
        
        cartView.onCartButtonTapped = { [weak self] in
            guard let self = self else { return }
            let vc = self.productViewModel.di.screenFactory.createCartScreen()
            
            vc.onDismissTapped = { [weak self] in
                self?.productViewModel.getCartTotal()
                self?.tableView.reloadData()
            }
            
            self.present(vc, animated: true)
            
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
        
        let cobainerDI = productViewModel.di
        let detailVC = cobainerDI.screenFactory.createDetailProductScreen(product: selectedProduct)
        detailVC.modalPresentationStyle = .fullScreen
        
        present(detailVC, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return section == 2 ? UITableView.automaticDimension : 0
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        switch section {
        case 2:
            guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: ProductContainerHeader.reuseId) as? ProductContainerHeader else { return UIView() }
            
            
            header.onFilterButtonTapped = { [weak self] selectedFoodType in
                guard let self = self else { return }
//                self.productContainer.onFilterButtonTapped?()
                if let index = self.productViewModel.products.firstIndex(where: {$0.foodType == selectedFoodType}) {
                    let indexPath = IndexPath(row: index, section: 2)
                    self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
                }
            }
            
            let filter = productViewModel.allFilters
            header.update(filter)
            return header
        default :
            return UIView()
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let visibleRows = tableView.indexPathsForVisibleRows ?? []
        
        guard let firstVisibleRow = visibleRows.first else { return }
        let product = productViewModel.products[firstVisibleRow.row]
        
        let foodType = product.foodType
        
        if let header = tableView.headerView(forSection: 2) as? ProductContainerHeader {
            header.selectedFilter(foodType: foodType)
        }
    }
}
