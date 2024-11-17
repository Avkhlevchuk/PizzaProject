//
//  IngredientsCollectionCell.swift
//  PizzaProject
//
//  Created by Artem Khlevchuk on 27.10.2024.
//

import UIKit

final class ToppingsContainerCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var onToppingTapped: ((Int)->())?
    
    var toppings = [Toppings]()
    
    var toppingsInOrder = [Toppings]()
    
    lazy var collectionView: UICollectionView = {
        var layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 130 , height: 180)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isScrollEnabled = true
        collectionView.backgroundColor = .white
        collectionView.registerCell(ToppingsCollectionCell.self)
        
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
            make.top.bottom.equalTo(contentView)
            make.left.right.equalTo(contentView).inset(10)
            make.height.equalTo(400)
        }
    }
    
    func toppingTapped(index: Int) {
        onToppingTapped?(index)
    }
}

//MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension ToppingsContainerCell {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return toppings.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(indexPath) as ToppingsCollectionCell
        let topping = toppings[indexPath.row]
        cell.update(topping: topping)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let cell = collectionView.cellForItem(at: indexPath) as? ToppingsCollectionCell {
            cell.isSelectedCell.toggle()
        }
        
        toppingTapped(index: indexPath.row)
    }
}

//MARK: - Event Handler

extension ToppingsContainerCell {
    
    func bind(toppings: [Toppings]) {
        self.toppings = toppings
    }
}
