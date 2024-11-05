//
//  DetailViewController.swift
//  PizzaProject
//
//  Created by Artem Khlevchuk on 16.10.2024.
//

import UIKit
import SnapKit

class DetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
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
    
    init (detailProductViewModel: DetailProductViewModel) {
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
            make.height.equalTo(100)
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
//            let pizzaProduct = self.detailProductViewModel.getProduct()
            self.titleDetailView.update(product)
        }
        
        
        addProduct.onAddButtonTapped = { [weak self] in
            guard let self = self else { return }
            addProduct.addToCard(product: product)
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
        
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailProductViewCell.reuseId, for: indexPath) as? DetailProductViewCell else { return UITableViewCell() }
            cell.selectionStyle = .none
            cell.update(product)
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: IngredientDetailTableViewCell.reuseId, for: indexPath) as? IngredientDetailTableViewCell else { return UITableViewCell() }
            cell.selectionStyle = .none
            cell.update(product)
            
            cell.onInfoButtonTapped = { [weak self] in
                guard let self = self else { return }
                self.ingredientDetailProductTableView.onInfoButtonTapped?()
                //Popover
                
                
                
                //Tooltip
                
                tableView.subviews.forEach { subview in
                    if subview is ToolTipView {
                        subview.removeFromSuperview()
                    }
                }

                // Текст для ToolTipView
                let toolTipText = """
                    Nutrition facts (per 100 g)
                    Weight                            630 g
                    Calories                   229.2 kcal
                    Protein                                8.7 g
                    Fats                                   7.2 g
                    Carbohydrates                30.9 g
                    May contain: gluten, milk and its products
                    (including lactose), as well as some other
                    allergens: vdo.do/ru_nutrition
                """

                // Позиция всплывающей подсказки относительно кнопки
                let tooltipPosition: ToolTipPosition = .middle

                // Создаем ToolTipView
                
                var title: UILabel = {
                    let title = UILabel()
                    title.text = "Sweet Chilli shrimp"
                    title.textColor = .white
                    return title
                }()
                
                let tooltipView = ToolTipView(
                    frame: CGRect(x: 0, y: 0, width: 350, height: 250), // Укажите нужный размер
                    text: toolTipText,
                    tipPos: tooltipPosition,
                    titleLabel: title
                )
                
                
//                tooltipView.center = CGPoint(x: ingredientDetailProductTableView.infoWeightDescriptionButton.frame.minX - tooltipView.bounds.width / 500,
//                                             y: ingredientDetailProductTableView.infoWeightDescriptionButton.frame.maxY + tooltipView.bounds.height) // Добавлено смещение вниз
                tooltipView.center = CGPoint(x: 190, y: 568) // Добавлено смещение вниз
                

                tableView.addSubview(tooltipView)
//                tableView.bringSubviewToFront(tooltipView)
                
            }
            
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ToppingsContainerCell.reuseId, for: indexPath) as? ToppingsContainerCell else { return UITableViewCell() }
            cell.selectionStyle = .none
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
}
