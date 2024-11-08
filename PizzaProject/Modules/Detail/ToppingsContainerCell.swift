//
//  IngredientsCollectionCell.swift
//  PizzaProject
//
//  Created by Artem Khlevchuk on 27.10.2024.
//

import UIKit

final class ToppingsContainerCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    
    static let reuseId = "IngredientsContainerCell"
    
    var productViewModel = ProductViewModel(di: DependencyContainer())
    
    lazy var collectionView: UICollectionView = {
        var layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 125 , height: 160)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isScrollEnabled = true
        collectionView.backgroundColor = .white
        collectionView.register(ToppingsCollectionCell.self, forCellWithReuseIdentifier: ToppingsCollectionCell.reuseId)
        
        return collectionView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        contentView.addSubview(collectionView)
    }
    
    func setupConstraints() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
            make.height.equalTo(350)
        }
    }
}

//MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension ToppingsContainerCell {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productViewModel.allToppings.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ToppingsCollectionCell.reuseId, for: indexPath) as? ToppingsCollectionCell else { return UICollectionViewCell() }
        let topping = productViewModel.allToppings[indexPath.row]
        cell.update(topping: topping)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let topping = productViewModel.allToppings[indexPath.row]
        
//        productViewModel.di?.productViewModel.toppingsInOrder
        
        if productViewModel.toppingsInOrder.isEmpty {
            productViewModel.toppingsInOrder.append(topping)
        } else if productViewModel.toppingsInOrder.contains(where: { $0.id == topping.id }) {
            productViewModel.toppingsInOrder.removeAll { $0.id == topping.id }
        } else {
            productViewModel.toppingsInOrder.append(topping)
        }
        
    }
}
