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
    
    var saveAndBackView = SaveAndBackView()
    
    var onDismissTapped: (()->())?
    
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
        setupBinding()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if !detailProductViewModel.saveRemovedIngredients {
            detailProductViewModel.ingretientStatesInOrder = []
            detailProductViewModel.listRemovedIngredients = nil
        } else {
            detailProductViewModel.clearUnsavedIngredients()
        }
        
        if self.isMovingToParent || self.isBeingDismissed {
            onDismissTapped?()
        }
    }
    
    func setupViews() {
        [saveAndBackView, tableView].forEach {
            view.addSubview($0)
        }
        view.backgroundColor = .white
    }
    
    func setupConstraints() {
        
        saveAndBackView.snp.makeConstraints { make in
            make.left.right.top.equalTo(view)
            make.height.greaterThanOrEqualTo(50)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(saveAndBackView.snp.bottom)
            make.left.right.bottom.equalTo(view)
        }
    }
    
    func setupBinding() {
        saveAndBackView.onCloseButtonTapped = { [weak self] in
            guard let self = self else { return }
            
            self.detailProductViewModel.resetRemovedIngredientStates()
            self.dismiss(animated: true, completion: nil)
        }
        saveAndBackView.onSaveButtonTapped = { [weak self] in
            guard let self = self else { return }
            
            self.detailProductViewModel.saveRemovedIngredients = true
            self.detailProductViewModel.savedRemovedIngredients()
            self.detailProductViewModel.createLineWithRemovedIngredients()
            self.dismiss(animated: true, completion: nil)
        }
        saveAndBackView.onResetButtonTapped = { [weak self] in
            guard let self = self else { return }
            
            self.detailProductViewModel.resetRemovedIngredientStates()
            self.detailProductViewModel.saveRemovedIngredients = false
            self.detailProductViewModel.clearUnsavedIngredients()
            self.detailProductViewModel.listRemovedIngredients = nil
            self.saveAndBackView.showCloseButton()
            self.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(indexPath) as RemoveContainerIngredientsCell
        
        cell.bind(ingredients: detailProductViewModel.product.ingredients, ingredientStates: detailProductViewModel.ingretientStatesInOrder, saved: detailProductViewModel.saveRemovedIngredients)
        
        cell.onSelectItemTapped = { [weak self] ingredientStates in
            guard let self = self else { return }
           
            let countRemovedIngredients = ingredientStates.filter { $0.isRemoved }.count
           
            if countRemovedIngredients == 0 {
                self.saveAndBackView.showCloseButton()
            } else if countRemovedIngredients > 0 {
                self.saveAndBackView.showSaveAndResetButton()
            }
            self.detailProductViewModel.ingretientStatesInOrder = ingredientStates
        }
        return cell
    }
}
