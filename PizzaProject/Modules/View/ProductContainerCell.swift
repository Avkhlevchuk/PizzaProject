//
//  ProductContainerCell.swift
//  PizzaProject
//
//  Created by Artem Khlevchuk on 27.09.2024.
//

import UIKit

class ProductContainerCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var foodType: [FoodType] = []
    
    let productViewModel = ProductViewModel()
    
    var onFilterButtonTapped: (()->())?
    
    static let reuseId = "ProductContainerCell"
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.collectionView?.backgroundColor = Colors.backgroundColor
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
//        collectionView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        collectionView.register(BannerCollectionCell.self, forCellWithReuseIdentifier: BannerCollectionCell.reuseId)
        collectionView.backgroundColor = .white
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        collectionView.layer.cornerRadius = 40
        //collectionView.layer.masksToBounds = true
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
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerCollectionCell.reuseId, for: indexPath) as? BannerCollectionCell else { return UICollectionViewCell() }

        cell.update(foodType[indexPath.row])
        
        cell.onButtonTapped = { [weak self] in
            guard let self = self else { return }
            self.onFilterButtonTapped?()
        }
        
        return cell
    }
//MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           let foodType = foodType[indexPath.row]
           let label = UILabel()
           label.text = foodType.rawValue
           label.font = UIFont.systemFont(ofSize: 14)
           label.sizeToFit()
           
           // Добавляем отступы для текста
           let itemWidth = label.frame.width + 15
           let itemHeight: CGFloat = 25
           
           return CGSize(width: itemWidth, height: itemHeight)
       }
    
}

extension ProductContainerCell {
    func update (_ foodType: [FoodType]) {
        self.foodType = foodType
    }
}
