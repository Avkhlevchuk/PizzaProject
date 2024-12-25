//
//  DetailViewController.swift
//  PizzaProject
//
//  Created by Artem Khlevchuk on 16.10.2024.
//

import UIKit
import SnapKit

final class DetailViewController: UIViewController {
    
    ///subscription on onEditButtonTapped in EditProductView
    var onEditButtonTapped: (()->())?
    
    private lazy var toppingInfoPopoverViewController = ToppingInfoPopoverViewController()
    
    private var isPopoverPresented = false
    
    private var titleDetailView = TitleDetailView()
    private var detailProductViewModel: IDetailProductViewModel
    private var ingredientDetailProductTableView = IngredientDetailTableViewCell()
    private var addProduct = AddProductView()
    private var editProduct = EditProductView()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.contentInset = .init(top: 30, left: 0, bottom: -35, right: 0)
        tableView.backgroundColor = Colors.backGroundBeige
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.registerCell(DetailProductViewCell.self)
        tableView.registerCell(IngredientDetailTableViewCell.self)
        tableView.registerCell(ToppingsContainerCell.self)
        let footerView = UIView.init(frame: CGRect(x: 0, y: 0, width: 0, height: 100))
        footerView.backgroundColor = .white
        tableView.tableFooterView = footerView
        
        return tableView
    }()
    
    init (detailProductViewModel: IDetailProductViewModel) {
        self.detailProductViewModel = detailProductViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchOrder()
        setupViews()
        setupConstraints()
        setupBinding()
        updateTitleDetailView()
    }
}

//MARK: - Layout
extension DetailViewController {
    private func setupViews() {
        [tableView, titleDetailView].forEach { view.addSubview($0) }
        setupStateView()
    }
    
    private func setupConstraints() {
        
        titleDetailView.snp.makeConstraints { make in
            make.left.right.equalTo(view)
            make.top.equalTo(view)
            make.height.equalTo(105)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalToSuperview()
        }
        
        setupStateConstraints()
    }
    
    private func setupStateView() {
        switch detailProductViewModel.detailProductState  {
        case .createOrder:
            view.addSubview(addProduct)
        case .editOrder:
            view.addSubview(editProduct)
        }
    }
    
    private func setupStateConstraints() {
        switch detailProductViewModel.detailProductState  {
        case .createOrder:
            addProduct.snp.makeConstraints { make in
                make.left.right.equalTo(view)
                make.bottom.equalToSuperview()
                make.height.equalTo(100)
            }
        case .editOrder:
            editProduct.snp.makeConstraints { make in
                make.left.right.equalTo(view)
                make.bottom.equalToSuperview()
                make.height.equalTo(100)
            }
        }
    }
}

//MARK: - UITableViewDataSource, UITableViewDelegate

enum DetailSection: Int, CaseIterable {
    case detailProduct, ingredients, toppings
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return DetailSection.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let detailSection = DetailSection(rawValue: section) else { return 0 }
        
        switch detailSection {
        case .detailProduct, .ingredients, .toppings:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let detailSection = DetailSection(rawValue: indexPath.section) else { return UITableViewCell() }
        
        switch detailSection {
            
        case .detailProduct:
            return configureDatailProductCell(for: indexPath)
        case .ingredients:
            return configureIngredientsCell(for: indexPath)
        case .toppings:
            return configureToppingsCell(for: indexPath)
        }
    }
    
    private func configureDatailProductCell(for indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(indexPath) as DetailProductViewCell
        cell.selectionStyle = .none
        cell.update(detailProductViewModel.product)
        
        switch detailProductViewModel.detailProductState {
        case .createOrder:
            break
        case .editOrder:
            let selectedSize = detailProductViewModel.sizePizza
            let typeBasePizza = detailProductViewModel.typeBasePizza
            cell.updateSelectedSegmentControll(selectedSize: selectedSize, selectedTypeBasePizza: typeBasePizza)
        }
        
        setupDetailProductCellBinding(cell)
        
        return cell
    }
    
    private func configureIngredientsCell(for indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(indexPath) as IngredientDetailTableViewCell
        cell.selectionStyle = .none
        
        let product = detailProductViewModel.product
        
        cell.update(product: product, listRemovedIngredients: detailProductViewModel.listRemovedIngredients)
        
        setupIngredientsCellBinding(cell, product: product)
        
        return cell
    }
    
    private func configureToppingsCell(for indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(indexPath) as ToppingsContainerCell
        cell.selectionStyle = .none
        
        let toppings = detailProductViewModel.allToppings
        
        let toppingsInOrder = detailProductViewModel.toppingsInOrder
        
        cell.bind(toppings: toppings, toppingsInOrder: toppingsInOrder)
        
        setupToppingsCellBinding(cell)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}
//MARK: - Binding

extension DetailViewController {
    
    private func setupBinding() {
        
        let product = detailProductViewModel.getProduct()
        
        closeScreenDetailViewController()
        
        detailProductViewModel.onProductUpdate = { [weak self] in
            self?.titleDetailView.update(product)
        }
        
        switch detailProductViewModel.detailProductState  {
        case .createOrder:
            
            addProduct.update(product.price)
            
            addProduct.onAddButtonTapped = { [weak self] in
                
                self?.detailProductViewModel.addToCard()
                self?.dismiss(animated: true, completion: nil)
            }
            
        case .editOrder:
            editProduct.update(detailProductViewModel.getTotalPrice())
            
            editProduct.onEditButtonTapped = { [weak self] in
                
                self?.detailProductViewModel.editPosition()
                self?.onEditButtonTapped?()
                self?.dismiss(animated: true, completion: nil)
            }
        }
    }
    //MARK: - Cell Binding
    private func setupDetailProductCellBinding(_ cell: DetailProductViewCell) {
        
        cell.onSegmentControlSizeTapped = { [weak self] namePizzaSize in
            self?.handlerSizeSelection(namePizzaSize)
        }
        
        cell.onSegmentControlBaseTapped = { [weak self] namePizzaBase in
            self?.detailProductViewModel.typeBasePizza = namePizzaBase
        }
    }
    
    private func setupIngredientsCellBinding(_ cell: IngredientDetailTableViewCell, product: Pizza) {
        
        cell.onInfoButtonTapped = { [weak self] sender in
            guard let self = self else { return }
            let nutritionValueProduct = self.detailProductViewModel.getNutritionValue(id: product.id)
            self.createPopover(sender: sender, nutritionValueProduct: nutritionValueProduct)
        }
        
        cell.onRemoveIngredientsButtonTapped = { [weak self] in
            self?.presentRemoveIngredientsScreen()
            
        }
    }
    
    private func setupToppingsCellBinding(_ cell: ToppingsContainerCell) {
        
        cell.onToppingTapped = { [weak self] index in
            guard let self = self else { return }
            
            let topping = self.detailProductViewModel.allToppings[index]
            let priceForPizza = self.detailProductViewModel.priceForPizza
            let sum = self.detailProductViewModel.calculateTotalPrice(topping: topping, priceForPizza: priceForPizza)
            
            updatePrice(sum: sum)
        }
    }
}

//MARK: - Event handler

extension DetailViewController {
    
    private func handlerSizeSelection(_ namePizzaSize: String) {
        detailProductViewModel.priceForPizza = Double(detailProductViewModel.product.prices["\(namePizzaSize)"] ?? detailProductViewModel.product.price)
        
        detailProductViewModel.updateSizeOfPizza(namePizzaSize: namePizzaSize)
        
        let totalPrice = detailProductViewModel.getTotalPrice()
        
        switch detailProductViewModel.detailProductState {
        case .createOrder:
            addProduct.update(totalPrice)
        case .editOrder:
            editProduct.update(totalPrice)
        }
    }
    
    private func updatePrice(sum: Double) {
        switch detailProductViewModel.detailProductState {
        case .createOrder:
            addProduct.update(sum)
        case .editOrder:
            editProduct.update(sum)
        }
    }
    
    private func presentRemoveIngredientsScreen() {
        
        let removeVC = detailProductViewModel.di.screenFactory.createRemoveIngredientsScreen(detailProductViewModel: detailProductViewModel)
        
        removeVC.modalPresentationStyle = .pageSheet
        
        removeVC.onDismissTapped = { [weak self] in
            guard let self = self else { return }
            self.tableView.reloadData()
        }
        
        if let sheet = removeVC.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
            sheet.prefersGrabberVisible = true
            sheet.prefersScrollingExpandsWhenScrolledToEdge = true
        }
        
        self.present(removeVC, animated: true)
    }
    
    private func updateTitleDetailView() {
        let product = detailProductViewModel.getProduct()
        titleDetailView.update(product)
    }
    
    private func presentPopover() {
        self.present(self.toppingInfoPopoverViewController, animated: true) { [weak self] in
            self?.isPopoverPresented = true
        }
    }
    
    private func popoverPresentationControllerDidDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) {
        isPopoverPresented = false
    }
}

//MARK: - Business logic

extension DetailViewController {
    
    private func fetchOrder() {
        switch detailProductViewModel.detailProductState {
        case .createOrder:
            break
        case .editOrder:
            detailProductViewModel.convertFromOrderToDataForDetailVM()
            tableView.reloadData()
        }
    }
}

//MARK: - Popover

extension DetailViewController {
    
    private func createPopover(sender: UIButton, nutritionValueProduct: NutritionValue) {
        guard !isPopoverPresented else { return }
        
        self.ingredientDetailProductTableView.onInfoButtonTapped?(sender)
        toppingInfoPopoverViewController.update(nutritionValue: nutritionValueProduct)
        
        toppingInfoPopoverViewController.preferredContentSize = .init(width: 350, height: 330)
        
        toppingInfoPopoverViewController.modalPresentationStyle = .popover
        
        let popoverPresentationController = toppingInfoPopoverViewController.popoverPresentationController
        
        popoverPresentationController?.permittedArrowDirections = .right
        
        popoverPresentationController?.sourceRect = sender.bounds
        
        popoverPresentationController?.sourceView = sender
        
        popoverPresentationController?.delegate = self
        
        if let presentedViewController {
            presentedViewController.dismiss(animated: true) { [weak self] in
                guard let self = self else { return }
                self.presentPopover()
            }
        } else {
            self.presentPopover()
        }
    }
}

//MARK: - Close screen

extension DetailViewController {
    
    private func closeScreenDetailViewController() {
        titleDetailView.onCloseButtonTaped = { [weak self] in
            self?.dismiss(animated: true, completion: nil)
        }
    }
}
