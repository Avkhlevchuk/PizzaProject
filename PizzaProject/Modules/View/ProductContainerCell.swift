//
//  ProductContainerCell.swift
//  PizzaProject
//
//  Created by Artem Khlevchuk on 27.09.2024.
//

import UIKit

class ProductContainerCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    
    static let reuseId = "ProductContainerCell"
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 100, height: 25)
        layout.minimumLineSpacing = 40
        layout.collectionView?.backgroundColor = Colors.backgroundColor
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
//        collectionView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        collectionView.register(BannerCollectionCell.self, forCellWithReuseIdentifier: BannerCollectionCell.reuseId)
        collectionView.backgroundColor = .white
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        collectionView.layer.cornerRadius = 15
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
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerCollectionCell.reuseId, for: indexPath) as? BannerCollectionCell else { return UICollectionViewCell() }
        return cell
    }
    
    
}
