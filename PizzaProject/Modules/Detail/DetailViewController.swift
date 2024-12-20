//
//  DetailViewController.swift
//  PizzaProject
//
//  Created by Artem Khlevchuk on 16.10.2024.
//

import UIKit
import SnapKit

class DetailViewController: UIViewController {
    
    private lazy var toppingInfoPopoverViewController = ToppingInfoPopoverViewController()
    
    var isPopoverPresented = false
    
    var titleDetailView = TitleDetailView()
    private var detailProductViewModel: IDetailProductViewModel
    var ingredientDetailProductTableView = IngredientDetailTableViewCell()
    var addProduct = AddProductView()
    var editProduct = EditProductView()
    
    var onEditButtonTapped: (()->())?
    
    lazy var tableView: UITableView = {
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
    
    let typeBasePizzaSegmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl()
        return segmentedControl
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
    }
    
    
//MARK: - Setup
    
    func setupViews() {
        [tableView, titleDetailView].forEach {
            view.addSubview($0)
        }
        
        switch detailProductViewModel.detailProductState  {
        case .createOrder:
            view.addSubview(addProduct)
        case .editOrder:
            view.addSubview(editProduct)
        }
    }
    
    func setupConstraints() {
        
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
    case detailProduct
    case ingredients
    case toppings
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return DetailSection.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let detailSection = DetailSection(rawValue: section) else { return 0 }
        
        switch detailSection {
        case .detailProduct:
            return 1
        case .ingredients:
            return 1
        case .toppings:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let detailSection = DetailSection(rawValue: indexPath.section) else { return UITableViewCell() }
        
        let product = detailProductViewModel.getProduct()
        detailProductViewModel.priceForPizza = Double(product.price)
        
        switch detailSection {
        case .detailProduct:
            let cell = tableView.dequeueCell(indexPath) as DetailProductViewCell
            cell.selectionStyle = .none
            cell.update(product)
            
            switch detailProductViewModel.detailProductState {
            case .createOrder:
                break
            case .editOrder:
                let selectedSize = detailProductViewModel.sizePizza
                let typeBasePizza = detailProductViewModel.typeBasePizza
                cell.updateSelectedSegmentControll(selectedSize: selectedSize, selectedTypeBasePizza: typeBasePizza)
            }
            
            cell.onSegmentControlSizeTapped = { [weak self] namePizzaSize in
                guard let self = self else { return }
                
                detailProductViewModel.priceForPizza = Double(detailProductViewModel.product.prices["\(namePizzaSize)"] ?? detailProductViewModel.product.price)
                
                detailProductViewModel.updateSizeOfPizza(namePizzaSize: namePizzaSize)
                
                let sum = detailProductViewModel.priceForPizza + detailProductViewModel.sumToppings
                
                switch detailProductViewModel.detailProductState {
                case .createOrder:
                    addProduct.update(sum)
                case .editOrder:
                    editProduct.update(sum)
                }
            }
            
            cell.onSegmentControlBaseTapped = { [weak self] namePizzaBase in
                self?.detailProductViewModel.typeBasePizza = namePizzaBase
            }
            
            return cell
            
        case .ingredients:
            let cell = tableView.dequeueCell(indexPath) as IngredientDetailTableViewCell
            cell.selectionStyle = .none
            
            cell.update(product: product, listRemovedIngredients: detailProductViewModel.listRemovedIngredients)
            
            let nutritionValueProduct = detailProductViewModel.getNutritionValue(id: product.id)
            
            cell.onInfoButtonTapped = { [weak self] sender in
                guard let self = self else { return }
                
                self.createPopover(sender: sender, nutritionValueProduct: nutritionValueProduct)
                
            }
            
            cell.onRemoveIngredientsButtonTapped = { [weak self] in
                guard let self = self else { return }
                
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
            return cell
        
        case .toppings:
            let cell = tableView.dequeueCell(indexPath) as ToppingsContainerCell
            cell.selectionStyle = .none
            
            let toppings = detailProductViewModel.allToppings
            
            let toppingsInOrder = detailProductViewModel.toppingsInOrder
            
            cell.bind(toppings: toppings, toppingsInOrder: toppingsInOrder)
            
            cell.onToppingTapped = { [weak self] index in
                guard let self = self else { return }
                
                let topping = self.detailProductViewModel.allToppings[index]
                let priceForPizza = self.detailProductViewModel.priceForPizza
                let sum = self.detailProductViewModel.calculateTotalPrice(topping: topping, priceForPizza: priceForPizza)
                
                switch detailProductViewModel.detailProductState {
                case .createOrder:
                    addProduct.update(sum)
                case .editOrder:
                    editProduct.update(sum)
                }
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
}
//MARK: - Event Handler

extension DetailViewController {
    
    func setupBinding() {
        
        let product = detailProductViewModel.getProduct()
        
        titleDetailView.onCloseButtonTaped = { [weak self] in
            self?.dismiss(animated: true, completion: nil)
        }
        
        detailProductViewModel.onProductUpdate = { [weak self] in
            guard let self = self else { return }
            self.titleDetailView.update(product)
        }
        
        switch detailProductViewModel.detailProductState  {
        case .createOrder:
            
            addProduct.onAddButtonTapped = { [weak self] in
                guard let self = self else { return }
                let toppings = self.detailProductViewModel.toppingsInOrder
                let sumForToppings = self.detailProductViewModel.sumToppings
                let priceForPizza = self.detailProductViewModel.priceForPizza
                let typeBasePizza = self.detailProductViewModel.typeBasePizza
                let removedIngredients = self.detailProductViewModel.ingredientStatesInOrder
                let sizePizza = detailProductViewModel.sizePizza
                
                self.detailProductViewModel.addToCard(product: product, removedIngredients: removedIngredients, toppings: toppings, sumForToppings: sumForToppings, priceForPizza: priceForPizza, sizePizza: sizePizza, typeBasePizza: typeBasePizza)
                
                self.dismiss(animated: true, completion: nil)
            }
            
        case .editOrder:
            
            editProduct.onEditButtonTapped = { [weak self] in
                guard let self = self else { return }
                let toppings = self.detailProductViewModel.toppingsInOrder
                let sumForToppings = self.detailProductViewModel.sumToppings
                let priceForPizza = self.detailProductViewModel.priceForPizza
                let typeBasePizza = self.detailProductViewModel.typeBasePizza
                let removedIngredients = self.detailProductViewModel.ingredientStatesInOrder
                let sizePizza = detailProductViewModel.sizePizza
                let orderId = detailProductViewModel.order?[0].orderId
                let count = detailProductViewModel.order?[0].count
                
                self.detailProductViewModel.editPosition(orderId: orderId ?? 0, count: count ?? 1, product: product, removedIngredients: removedIngredients, toppings: toppings, sumForToppings: sumForToppings, priceForPizza: priceForPizza, sizePizza: sizePizza, typeBasePizza: typeBasePizza)
                
                onEditButtonTapped?()
                self.dismiss(animated: true, completion: nil)
            }
        }
        
        titleDetailView.update(product)
        
        switch detailProductViewModel.detailProductState {
        case .createOrder:
            addProduct.update(product.price)
        case .editOrder:
            editProduct.update(detailProductViewModel.priceForPizza + detailProductViewModel.sumToppings)
        }
    }
    
    private func presentPopover() {
        self.present(self.toppingInfoPopoverViewController, animated: true) { [weak self] in
            self?.isPopoverPresented = true
        }
    }
    
    func popoverPresentationControllerDidDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) {
        isPopoverPresented = false
    }
}

//MARK: - Data fetching from DetailProductViewModel

extension DetailViewController {
    
    func fetchOrder() {
        switch detailProductViewModel.detailProductState {
        case .createOrder:
            break
        case .editOrder:
            detailProductViewModel.syncOrderAndEditProduct()
            tableView.reloadData()
        }
    }
}

//MARK: - Update View

extension DetailViewController {
    
    func createPopover(sender: UIButton, nutritionValueProduct: NutritionValue) {
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
