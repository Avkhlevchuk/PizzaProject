//
//  DetailViewController.swift
//  PizzaProject
//
//  Created by Artem Khlevchuk on 16.10.2024.
//

import UIKit
import SnapKit

class DetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private lazy var toppingInfoPopoverViewController = ToppingInfoPopoverViewController()
    private var di: DependencyContainer?
    
    var isPopoverPresented = false
    
    var titleDetailView = TitleDetailView()
    private let detailProductViewModel: DetailProductViewModel
    var ingredientDetailProductTableView = IngredientDetailTableViewCell()
    var addProduct = AddProductView()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        
        tableView.contentInset = .init(top: 30, left: 0, bottom: -35, right: 0)
        tableView.backgroundColor = Colors.backGroundBeige
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        
        tableView.register(DetailProductViewCell.self, forCellReuseIdentifier: DetailProductViewCell.reuseId)
        tableView.register(IngredientDetailTableViewCell.self, forCellReuseIdentifier: IngredientDetailTableViewCell.reuseId)
        tableView.register(ToppingsContainerCell.self, forCellReuseIdentifier: ToppingsContainerCell.reuseId)
        //        tableView.bounces = false
        let footerView = UIView.init(frame: CGRect(x: 0, y: 0, width: 0, height: 100))
        footerView.backgroundColor = .white
        tableView.tableFooterView = footerView
        
        return tableView
    }()
    
    let typeBasePizzaSegmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl()
        return segmentedControl
    }()
    
    init (detailProductViewModel: DetailProductViewModel, di: DependencyContainer) {
        self.detailProductViewModel = detailProductViewModel
        self.di = di
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
    }
    
    func setupViews() {
        [tableView, titleDetailView, addProduct].forEach {
            view.addSubview($0)
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
        
        addProduct.snp.makeConstraints { make in
            make.left.right.equalTo(view)
            make.bottom.equalToSuperview()
            make.height.equalTo(100)
        }
    }
    
    func setupBinding() {
        
        let product = detailProductViewModel.getProduct()

        
        titleDetailView.onCloseButtonTaped = { [weak self] in
            self?.dismiss(animated: true, completion: nil)
        }
        
        detailProductViewModel.onProductUpdate = { [weak self] in
            guard let self = self else { return }
            self.titleDetailView.update(product)
        }
        
        addProduct.onAddButtonTapped = { [weak self] in
            guard let self = self else { return }
            let toppings = self.detailProductViewModel.toppingsInOrder
            let sumForToppings = self.detailProductViewModel.sumToppings
            let priceForPizza = self.detailProductViewModel.priceForPizza
            let typeBasePizza = self.detailProductViewModel.typeBasePizza
            
            self.addProduct.addToCard(product: product, toppings: toppings, sumForToppings: sumForToppings, priceForPizza: priceForPizza, typeBasePizza: typeBasePizza)
        }
        
        titleDetailView.update(product)
        
        addProduct.update(product.price)
        
    }
    //MARK: - UITableViewDataSource, UITableViewDelegate
    
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
            return 1
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let product = detailProductViewModel.getProduct()
        detailProductViewModel.priceForPizza = Double(product.price)
        
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailProductViewCell.reuseId, for: indexPath) as? DetailProductViewCell else { return UITableViewCell() }
            cell.selectionStyle = .none
            cell.update(product)
            
            cell.onSegmentControlSizeTapped = { [weak self] namePizzaSize in
                guard let self = self else { return }
                
                detailProductViewModel.priceForPizza = Double(detailProductViewModel.product.prices["\(namePizzaSize)"] ?? detailProductViewModel.product.price)
                let sum = detailProductViewModel.priceForPizza + detailProductViewModel.sumToppings
                
                addProduct.update(sum)
            }
            
            cell.onSegmentControlBaseTapped = { [weak self] namePizzaBase in
                self?.detailProductViewModel.typeBasePizza = namePizzaBase
            }
            
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: IngredientDetailTableViewCell.reuseId, for: indexPath) as? IngredientDetailTableViewCell else { return UITableViewCell() }
            cell.selectionStyle = .none
            cell.update(product)
            let nutritionValueProduct = detailProductViewModel.getNutritionValue(id: product.id)
            
            cell.onInfoButtonTapped = { [weak self] sender in
                guard let self = self else { return }
                
                //Create popover
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
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ToppingsContainerCell.reuseId, for: indexPath) as? ToppingsContainerCell else { return UITableViewCell() }
            cell.selectionStyle = .none
            
            let toppings = detailProductViewModel.allToppings
            
            cell.bind(toppings: toppings)
            
            cell.onToppingTapped = { [weak self] index in
                guard let self = self else { return }
                
                let topping = self.detailProductViewModel.allToppings[index]
                let priceForPizza = self.detailProductViewModel.priceForPizza
                let sum = self.detailProductViewModel.calculateTotalPrice(topping: topping, priceForPizza: priceForPizza)
                
                addProduct.update(sum)
            }
            return cell
        default:
            return UITableViewCell()
        }
    }
}

//MARK: - Events Handler

extension DetailViewController {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
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
