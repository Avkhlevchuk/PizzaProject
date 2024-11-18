//
//  RemoveIngredientsCell.swift
//  PizzaProject
//
//  Created by Artem Khlevchuk on 18.11.2024.
//

import UIKit

class RemoveContainerIngredientsCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var ingredients = [Ingredient]()
    
    var onSelectItemTapped: (()->())?
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 0, right: 20)
        layout.minimumLineSpacing = 7
        layout.minimumInteritemSpacing = 7
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerCell(RemoveIngredientsCell.self)
        collectionView.backgroundColor = .white        
        return collectionView
        
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        contentView.addSubview(collectionView)
        contentView.backgroundColor = .white
    }
    
    func setupConstraints() {
        collectionView.snp.makeConstraints { make in
            make.left.right.equalTo(contentView)
            make.top.bottom.equalTo(contentView)
            make.height.greaterThanOrEqualTo(120)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ingredients.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(indexPath) as RemoveIngredientsCell
        cell.bind(ingredients: ingredients[indexPath.row])
        
        cell.onRemoveButtonTapped = { [weak self] in
            guard let self = self else { return }
            self.collectionView.collectionViewLayout.invalidateLayout()
            self.onSelectItemTapped?()
        }
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as?
            RemoveIngredientsCell {
            if ingredients[indexPath.row].removable {
                cell.removeIngredient()
            }
        }
    }
}

//MARK: - Event Handler

extension RemoveContainerIngredientsCell {
    func bind(ingredients: [Ingredient]) {
        self.ingredients = ingredients
        collectionView.reloadData()
    }
}
