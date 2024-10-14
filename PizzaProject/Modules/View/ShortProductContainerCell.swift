//
//  ShortProductContainerCell.swift
//  PizzaProject
//
//  Created by Artem Khlevchuk on 14.10.2024.
//

import UIKit

class ShortProductContainerCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
   
    let productViewModel = ProductViewModel()
    
    static let reuseId = "ShortProductContainerCell"
    
    lazy var collectionView: UICollectionView = {
        var layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 150
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ShortBannerCollectionCell.self, forCellWithReuseIdentifier: ShortBannerCollectionCell.reuseId)
        
        collectionView.backgroundColor = .white
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        collectionView.layer.cornerRadius = 20
        collectionView.layer.masksToBounds = true
        
        
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
        contentView.addSubview(collectionView)
    }
    
    func setupConstraints() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
            make.height.equalTo(110)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productViewModel.products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ShortBannerCollectionCell.reuseId, for: indexPath) as? ShortBannerCollectionCell else { return UICollectionViewCell() }
        
        return cell
    }
    
}

extension ShortProductContainerCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth = 80
        let itemHeight = 120
        return CGSize(width: itemWidth, height: itemHeight)
    }
}
