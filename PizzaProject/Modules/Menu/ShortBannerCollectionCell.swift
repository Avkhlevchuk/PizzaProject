//
//  ShortBannerCollectionCell.swift
//  PizzaProject
//
//  Created by Artem Khlevchuk on 14.10.2024.
//

import UIKit
import SnapKit

final class ShortBannerCollectionCell: UICollectionViewCell {
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var imageView = ImageView(style: .shortProduct)
        
    private lazy var verticalStackView = StackView(style: .vertical)
    
    private lazy var nameLabel = Label(style: .promoTitle)
    
    private lazy var priceButton = Button(style: .product)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Layout

extension ShortBannerCollectionCell {
    
    private func setupViews() {
        contentView.addSubview(containerView)
        
        [imageView, verticalStackView].forEach {
            containerView.addSubview($0)
        }
        
        [nameLabel, priceButton].forEach {
            verticalStackView.addArrangedSubview($0)
        }
    }
    
    private func setupConstraints() {
        
        containerView.snp.makeConstraints { make in
            make.edges.equalTo(containerView)
            
        }
        
        imageView.snp.makeConstraints { make in
            make.top.equalTo(contentView).inset(10)
            make.left.equalTo(contentView).inset(10)
            
        }
        
        verticalStackView.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.left.equalTo(imageView.snp.right).offset(5)
            make.right.equalTo(contentView).inset(10)
        }
        
    }
}

//MARK: - Public

extension ShortBannerCollectionCell {
    func update(_ product: Pizza) {
        imageView.image = UIImage(named: product.image)
        nameLabel.text = product.name
        priceButton.setTitle("from \(product.prices["small"] ?? 10) £", for: .normal)
    }
}
