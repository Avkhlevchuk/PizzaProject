//
//  PromoCell.swift
//  PizzaProject
//
//  Created by Artem Khlevchuk on 17.12.2024.
//

import UIKit

class PromoCell: UITableViewCell {
    
    lazy var containerPromoView: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.backGroundBeige
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.layer.cornerRadius = 110
        view.layer.masksToBounds = true
        
        return view
    }()
    
    var verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 10
        
        return stackView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 15)
        label.textAlignment = .left
        
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = .systemFont(ofSize: 12)
        label.textAlignment = .left
        label.numberOfLines = 0
        
        return label
    }()
    
    var priceButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("20 £", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .lightGray.withAlphaComponent(0.25)
        button.layer.cornerRadius = 12
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.contentEdgeInsets = UIEdgeInsets(top: 5, left: 20, bottom: 5, right: 20)
        
        return button
    }()
    
    var photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "pepperoni")
        imageView.contentMode = .scaleAspectFill
        let width = UIScreen.main.bounds.width
        imageView.heightAnchor.constraint(equalToConstant: 0.23 * width).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 0.23 * width).isActive = true
        
        return imageView
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
        self.addSubview(containerPromoView)
        
        [photoImageView, verticalStackView].forEach {
            self.addSubview($0)
        }
        
        [titleLabel, descriptionLabel, priceButton].forEach {
            verticalStackView.addSubview($0)
        }
    }
    func setupConstraints() {
        
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
//            make.bottom.equalTo(verticalStackView.snp.bottom)
        }
        priceButton.snp.makeConstraints { make in
            make.right.bottom.equalTo(verticalStackView).inset(10)
            
        }
    }
}

//MARK: - EVENTS HEANDLER

extension PromoCell {
    func bind(_ product: Pizza) {
        titleLabel.text = product.name
        descriptionLabel.text = product.ingredientsList
        photoImageView.image = UIImage(named: product.image)
        priceButton.setTitle("\(product.prices["small"] ?? 10) £", for: .normal)
    }
}
