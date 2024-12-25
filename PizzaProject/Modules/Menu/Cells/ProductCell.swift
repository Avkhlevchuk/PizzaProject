//
//  CustomeCell.swift
//  PizzaProject
//
//  Created by Artem Khlevchuk on 15.09.2024.
//

import UIKit
import SnapKit

class ProductCell: UITableViewCell {
    
    private var productContainerCell = CategoryContainerHeader()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 10
        return stackView
    }()
        
    private lazy var photoImageView = ImageView(style: .product)
    
    private lazy var nameLabel = Label(style: .promoTitle)
        
    private lazy var descriptionLabel = Label(style: .description)
        
    private lazy var priceButton = Button(style: .product)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Layout

extension ProductCell {
    
    private func setupView() {
        
        contentView.addSubview(containerView)
        [photoImageView, verticalStackView].forEach { containerView.addSubview($0) }
        [nameLabel, descriptionLabel, priceButton].forEach { verticalStackView.addArrangedSubview($0) }
    }
    
    private func setupConstraints() {
        
        containerView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
        
        photoImageView.snp.makeConstraints { make in
            make.left.top.equalTo(containerView).inset(15)
            make.bottom.lessThanOrEqualTo(containerView).inset(15)
            make.width.equalTo(photoImageView.snp.height)
        }
        
        verticalStackView.snp.makeConstraints { make in
            make.left.equalTo(photoImageView.snp.right).offset(20)
            make.top.equalTo(contentView).inset(15)
            make.right.equalTo(containerView).inset(15) 
            make.bottom.lessThanOrEqualTo(containerView).inset(15)
            
        }
    }
}

//MARK: - Public

extension ProductCell {
    func bind(_ product: Pizza) {
        nameLabel.text = product.name
        descriptionLabel.text = product.ingredientsList
        priceButton.setTitle("from \(product.prices["small"] ?? 10) £", for: .normal)
        photoImageView.image = UIImage(named: product.image)
    }
}
