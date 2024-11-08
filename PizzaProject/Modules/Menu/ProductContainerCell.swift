//
//  ProductContainerCell.swift
//  PizzaProject
//
//  Created by Artem Khlevchuk on 27.09.2024.
//

import UIKit

final class ProductContainerCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var foodType: [FoodType] = []
    
    let productViewModel = ProductViewModel(di: DependencyContainer())
    
    var onFilterButtonTapped: (()->())?
    
    static let reuseId = "ProductContainerCell"
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.collectionView?.backgroundColor = Colors.backgroundColor
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CategoryCollectionCell.self, forCellWithReuseIdentifier: CategoryCollectionCell.reuseId)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .white
        
        return collectionView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
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
            make.height.equalTo(50)
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
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionCell.reuseId, for: indexPath) as? CategoryCollectionCell else { return UICollectionViewCell() }

        cell.update(foodType[indexPath.row])
        
        cell.onButtonTapped = { [weak self] in
            guard let self = self else { return }
            self.onFilterButtonTapped?()
        }
        
        return cell
    }
}

extension ProductContainerCell {
    func update (_ foodType: [FoodType]) {
        self.foodType = foodType
    }
}
