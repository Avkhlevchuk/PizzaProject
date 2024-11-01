//
//  ShortProductContainerCell.swift
//  PizzaProject
//
//  Created by Artem Khlevchuk on 14.10.2024.
//

import UIKit
import SnapKit

class ShortProductContainerCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
   
    let productViewModel = ProductViewModel()
    
    static let reuseId = "ShortProductContainerCell"
    
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
        layout.itemSize = CGSize(width: 220 , height: 125)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .white
        collectionView.register(ShortBannerCollectionCell.self, forCellWithReuseIdentifier: ShortBannerCollectionCell.reuseId)

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
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productViewModel.products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ShortBannerCollectionCell.reuseId, for: indexPath) as? ShortBannerCollectionCell else { return UICollectionViewCell() }
        
        let product = productViewModel.products[indexPath.row]
        cell.update(product)
        
        return cell
    }
    
}