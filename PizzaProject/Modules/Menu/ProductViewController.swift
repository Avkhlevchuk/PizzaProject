//
//  ViewController.swift
//  PizzaProject
//
//  Created by Artem Khlevchuk on 15.09.2024.
//

import UIKit
import SnapKit

final class ProductViewController: UIViewController {
    private let productContainer = CategoryContainerHeader()
    private var productViewModel: IProductViewModel
    private let productShortContainer = ShortProductContainerCell()
    private let cartView = CartView()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = Colors.backgroundColor
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.registerCell(ProductCell.self)
        tableView.registerCell(ShortProductContainerCell.self)
        tableView.registerHeaderFooterView(CategoryContainerHeader.self)
        tableView.registerCell(StoryContainerCell.self)
        tableView.registerCell(PromoCell.self)
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
    
    private func setupViews() {
        view.backgroundColor = Colors.backgroundColor
        [tableView, cartView].forEach { view.addSubview($0) }
    }
    
    private func setupConstraints() {
        
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
}
//MARK: - Binding

extension ProductViewController {
    private func setupBinding() {
        
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
    //MARK: - Cell Binding
    private func setupShortProductCellBinding(_ cell: ShortProductContainerCell) {
        cell.onShortProductTapped = { [weak self] index in
            
            guard let self = self else { return }
            
            let selectedProduct = productViewModel.products[index]
            
            navigateToProductDetail(selectedProduct: selectedProduct)
        }
    }
    
    private func setupCategoryCellBinding(_ header: CategoryContainerHeader) {
        header.onFilterButtonTapped = { [weak self] selectedFoodType in
            guard let self = self else { return }
            let indexPath = self.productViewModel.fetchIndexSelectedCategory(selectedFoodType: selectedFoodType)
            self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
        }
    }
}

//MARK: - TableViewDataSource, TableViewDelegate

enum MenuSection: Int, CaseIterable {
    case stories
    case shortProducts
    case products
}

extension ProductViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return MenuSection.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let menuSection = MenuSection(rawValue: section) else { return 0 }
        
        switch menuSection {
        case .stories, .shortProducts:
            return 1
        case .products:
            return productViewModel.products.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let menuSection = MenuSection(rawValue: indexPath.section) else { return UITableViewCell() }
        
        switch menuSection {
        case .stories:
            let cell = tableView.dequeueCell(indexPath) as StoryContainerCell
            return cell
        case .shortProducts:
            let cell = tableView.dequeueCell(indexPath) as ShortProductContainerCell
            let product = productViewModel.products
            cell.bind(product: product)
            setupShortProductCellBinding(cell)
            return cell
        case .products:
            let product = productViewModel.products[indexPath.row]
            
            if product.isPromo {
                let cell = tableView.dequeueCell(indexPath) as PromoCell
                cell.selectionStyle = .none
                cell.bind(product)
                return cell
            } else {
                let cell = tableView.dequeueCell(indexPath) as ProductCell
                cell.selectionStyle = .none
                cell.bind(product)
                return cell
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedProduct = productViewModel.products[indexPath.row]
        
        navigateToProductDetail(selectedProduct: selectedProduct)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        guard let menuSection = MenuSection(rawValue: section) else { return 0 }
        
        return menuSection.rawValue == 2 ? UITableView.automaticDimension : 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        guard let menuSection = MenuSection(rawValue: section) else { return UIView() }
        
        switch menuSection {
        case .products:
            let header = tableView.dequeueHeader() as CategoryContainerHeader
            setupCategoryCellBinding(header)
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
        
        if let header = tableView.headerView(forSection: 2) as? CategoryContainerHeader {
            header.selectedFilter(foodType: foodType)
        }
    }
}

//MARK: - Navigation

extension ProductViewController {
    private func navigateToProductDetail(selectedProduct: Pizza) {
        let cobainerDI = productViewModel.di
        let detailVC = cobainerDI.screenFactory.createDetailProductScreen(product: selectedProduct)
        detailVC.modalPresentationStyle = .fullScreen
        
        present(detailVC, animated: true)
    }
}
