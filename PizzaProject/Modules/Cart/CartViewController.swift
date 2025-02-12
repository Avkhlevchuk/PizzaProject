//
//  CartViewController.swift
//  PizzaProject
//
//  Created by Artem Khlevchuk on 25.11.2024.
//

import UIKit
import SnapKit

final class CartViewController: UIViewController {
    
    private var cartViewModel: ICartViewModel
    private var closeAndTitleView = CloseAndTitleView()
    
    /// subscription to close screen CartView
    var onDismissTapped: (()->())?
    
    private lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.text = "2 Items for 50 £ "
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 22 )
        label.backgroundColor = .white
        label.textColor = .black
        label.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50)
        return label
    }()
    
    lazy var tableview: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 130
        tableView.registerCell(CartCell.self)
        tableView.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        return tableView
    }()
    
    init(cartViewModel: ICartViewModel) {
        self.cartViewModel = cartViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        
        reloadData()
        setupViews()
        setupConstraints()
        setupBinding()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        onDismissTapped?()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Layout

extension CartViewController {
    
    func setupViews() {
        
        view.backgroundColor = .white
        tableview.tableHeaderView = headerLabel
        
        [tableview, closeAndTitleView].forEach {
            view.addSubview($0)
        }
    }
    
    func setupConstraints() {
        
        closeAndTitleView.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.height.greaterThanOrEqualTo(50)
        }
        
        headerLabel.snp.makeConstraints { make in
            make.left.equalTo(view).inset(10)
        }
        
        tableview.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.bottom.equalToSuperview()
        }
        
    }
}

//MARK: - UITableViewDataSource, UITableViewDelegate

extension CartViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartViewModel.order.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueCell(indexPath) as CartCell
        let order = cartViewModel.order[indexPath.row]
        cell.bind(order: order)
        
        cell.onDecrementButtonTapped = { [weak self] in
            self?.cartViewModel.recordArchiver.removeCountPosition(index: indexPath.row)
            self?.reloadData()
            
        }
        
        cell.onIncrementButtonTapped = { [weak self] in
            self?.cartViewModel.recordArchiver.addCountPosition(index: indexPath.row)
            self?.reloadData()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            cartViewModel.recordArchiver.removePosition(index: indexPath.row)
            reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let product = cartViewModel.order[indexPath.row].product
        let order = cartViewModel.order[indexPath.row]
        let vc = (cartViewModel.di.screenFactory.editOrderDetailProductScreen(product: product, order: [order]))
        vc.modalPresentationStyle = .fullScreen
        
        vc.onEditButtonTapped = { [weak self] in
            self?.reloadData()
        }
        
        self.present(vc, animated: true)
    }
}

//MARK: - Binding

extension CartViewController {
    
    func setupBinding() {
        closeAndTitleView.onCloseButtonTapped = { [weak self] in
            self?.dismiss(animated: true, completion: nil)
        }
    }
}

//MARK: - Event Handler

extension CartViewController {
    
    private func reloadData() {
        cartViewModel.getOrder()
        cartViewModel.getСalculateTotalPriceForOrder()
        
        let countItems = cartViewModel.order.reduce(0) { $0 + $1.count }
        
        let headerTitle = "\(countItems) items for \(cartViewModel.totalPrice) £"
        headerLabel.text = headerTitle
        
        tableview.reloadData()
    }
}
