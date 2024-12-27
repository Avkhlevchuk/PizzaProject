//
//  PromoCell.swift
//  PizzaProject
//
//  Created by Artem Khlevchuk on 17.12.2024.
//

import UIKit
import SnapKit

class PromoCell: UITableViewCell {
    
    private lazy var containerPromoView: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.backGroundBeige
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.layer.cornerRadius = 110
        view.layer.masksToBounds = true
        
        return view
    }()
        
    private lazy var verticalStackView = StackView(style: .vertical)
    
    private lazy var titleLabel = Label(style: .promoTitle)
    
    private lazy var descriptionLabel = Label(style: .promoDescription)
    
    private lazy var priceButton = Button(style: .promo)
    
    private lazy var photoImageView = ImageView(style: .product)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Layout

extension PromoCell {
    
    private func setupViews() {
        self.addSubview(containerPromoView)
        
        [photoImageView, verticalStackView].forEach { self.addSubview($0) }
        
        [titleLabel, descriptionLabel, priceButton].forEach { verticalStackView.addSubview($0) }
    }
    
    private func setupConstraints() {
        
        containerPromoView.snp.makeConstraints { make in
            make.left.right.bottom.equalTo(self).inset(10)
            make.top.equalTo(self).inset(20)
            make.height.equalTo(200)
        }
        
        photoImageView.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).inset(30)
            make.centerX.equalTo(self)
            make.bottom.lessThanOrEqualTo(self).inset(15)
            make.width.equalTo(photoImageView.snp.height)
        }
        
        verticalStackView.snp.makeConstraints { make in
            make.left.right.bottom.equalTo(self).inset(10)
            make.top.equalTo(photoImageView.snp.bottom)
            make.bottom.lessThanOrEqualTo(containerPromoView.snp.bottom)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.left.top.equalTo(verticalStackView).offset(10)
            
        }
        descriptionLabel.snp.makeConstraints { make in
            make.left.right.equalTo(verticalStackView).offset(10)
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
        }
        priceButton.snp.makeConstraints { make in
            make.right.bottom.equalTo(verticalStackView).inset(10)
            
        }
    }
}

//MARK: - Public

extension PromoCell {
    func bind(_ product: Pizza) {
        titleLabel.text = product.name
        descriptionLabel.text = product.ingredientsList
        photoImageView.image = UIImage(named: product.image)
        priceButton.setTitle("\(product.prices["small"] ?? 10) £", for: .normal)
    }
}
