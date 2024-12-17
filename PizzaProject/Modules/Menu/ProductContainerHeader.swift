//
//  ProductContainerCell.swift
//  PizzaProject
//
//  Created by Artem Khlevchuk on 27.09.2024.
//

import UIKit

final class ProductContainerHeader: UITableViewHeaderFooterView, UICollectionViewDelegate, UICollectionViewDataSource {
        
    var foodType: [String] = []
    
    let productViewModel = ProductViewModel(di: DependencyContainer())
    
    var onFilterButtonTapped: ((String)->())?
    
    var selectedFoodType: String?
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.collectionView?.backgroundColor = Colors.backgroundColor
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerCell(CategoryCollectionCell.self)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .white
        collectionView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        return collectionView
    }()
    
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        
//    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupView()
        setupConstraints()
        setupBinding()
        
        productViewModel.fetchFilters()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        contentView.backgroundColor = Colors.backgroundColor
        contentView.addSubview(collectionView)
    }
    
    func setupConstraints() {
        collectionView.snp.makeConstraints { make in
            make.left.right.equalTo(contentView)
            make.top.bottom.equalTo(contentView)
//            make.height.equalTo(50)
        }
    }
    
    func setupBinding() {
        productViewModel.onFilterFetch = { [weak self] in
            self?.collectionView.reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return foodType.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(indexPath) as CategoryCollectionCell
        
        let foodTypeItem = foodType[indexPath.row]
        cell.update(foodTypeItem)
        
        if foodTypeItem == selectedFoodType {
            cell.setSelected(true)
        } else {
            cell.setSelected(false)
        }
        
        cell.onButtonTapped = { [weak self] in
            guard let self = self else { return }
            selectedFoodType = foodTypeItem
            collectionView.reloadData()
            self.onFilterButtonTapped?(foodTypeItem)
        }
        
        return cell
    }
}

extension ProductContainerHeader {
    func update (_ foodType: [String]) {
        self.foodType = foodType
    }
    
    func selectedFilter(foodType: String) {
        guard let index = self.foodType.firstIndex(of: foodType) else { return }
        let indexPath = IndexPath(item: index, section: 0)
        
        selectedFoodType = self.foodType[index]

        collectionView.scrollToItem(at: indexPath, at: .left, animated: true)
        collectionView.reloadData()
    }
}
