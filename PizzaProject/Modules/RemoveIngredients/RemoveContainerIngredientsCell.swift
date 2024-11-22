//
//  RemoveIngredientsCell.swift
//  PizzaProject
//
//  Created by Artem Khlevchuk on 18.11.2024.
//
//
import UIKit

class RemoveContainerIngredientsCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var ingredientStates: [IngredientStates] = []
    
    var onSelectItemTapped: (([IngredientStates])->())?
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.sectionInset = UIEdgeInsets(top: 10, left: 20, bottom: 0, right: 20)
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
        return ingredientStates.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(indexPath) as RemoveIngredientsCell
        let ingredientState = ingredientStates[indexPath.row]
        cell.bind(ingredients: ingredientState)
    
        return cell
    }
        
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
                
        if ingredientStates[indexPath.row].ingredient.isRemovable {
            ingredientStates[indexPath.row].isRemoved.toggle()
        }
            collectionView.reloadData()
        
        onSelectItemTapped?(ingredientStates)
    }
}

//MARK: - Event Handler

extension RemoveContainerIngredientsCell {
    func bind(ingredients: [Ingredient], ingredientStates: [IngredientStates], saved: Bool) {
        
        if !ingredientStates.isEmpty && saved {
            self.ingredientStates = ingredientStates
        } else {
            self.ingredientStates = []
            ingredients.forEach { self.ingredientStates.append(IngredientStates(ingredient: $0, isRemoved: false)) }
        }
        
        collectionView.reloadData()
    }
}
