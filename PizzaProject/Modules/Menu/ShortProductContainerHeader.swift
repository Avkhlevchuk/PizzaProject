//
//  ShortProductContainerCell.swift
//  PizzaProject
//
//  Created by Artem Khlevchuk on 14.10.2024.
//

import UIKit
import SnapKit

final class ShortProductContainerCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var onShortProductTapped: ((Int)->())?
   
    private var products = [Pizza]()
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "New and popular"
        label.font = UIFont.systemFont(ofSize: 16, weight: .heavy)
        label.textColor = .black
        
        return label
    }()
    
    lazy var collectionView: UICollectionView = {
        var layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 230 , height: 125)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .white
        collectionView.registerCell(ShortBannerCollectionCell.self)

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
        contentView.backgroundColor = Colors.backgroundColor
        contentView.addSubview(containerView)
        containerView.addSubview(titleLabel)
        
        contentView.addSubview(collectionView)
    }
    
    func setupConstraints() {
        
        containerView.snp.makeConstraints { make in
            make.left.right.top.equalTo(contentView)
            make.height.equalTo(30)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.left.top.equalTo(containerView).offset(10)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.bottom)
            make.left.right.bottom.equalTo(contentView)
            make.height.equalTo(125)
        }
    }
    
    func shortProductTapped(index: Int) {
        onShortProductTapped?(index)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return productViewModel.products.count
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(indexPath) as ShortBannerCollectionCell
        let product = products[indexPath.row]
        cell.update(product)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let cell = collectionView.cellForItem(at: indexPath) as? ToppingsCollectionCell {
            cell.isSelectedCell.toggle()
        }
        
        shortProductTapped(index: indexPath.row)
    }
}

//MARK: - External func

extension ShortProductContainerCell {
    func bind(product: [Pizza]) {
        self.products = product
        self.collectionView.reloadData()
    }
}
