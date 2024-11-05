//
//  CustomeCell.swift
//  PizzaProject
//
//  Created by Artem Khlevchuk on 15.09.2024.
//

import UIKit
import SnapKit

class ProductCell: UITableViewCell {
    
    var productContainerCell = ProductContainerCell()
    
    static let reuseId = "ProductCell"
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    var verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 10
        return stackView
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
    
    var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Пеперони"
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Пеперони, моцарела, помидоры"
        label.textColor = .black
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    var priceButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("от 100 ₽", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .lightGray.withAlphaComponent(0.25)
        button.layer.cornerRadius = 12
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.contentEdgeInsets = UIEdgeInsets(top: 5, left: 6, bottom: 5, right: 6)
       
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupView() {
        
        contentView.addSubview(containerView)
        
        [photoImageView, verticalStackView].forEach {
            containerView.addSubview($0)
        }
        
        [nameLabel, descriptionLabel, priceButton].forEach {
            verticalStackView.addArrangedSubview($0)
        }
        
    }
    
    func setupConstraints() {
        
        containerView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
        
        photoImageView.snp.makeConstraints { make in
            make.left.top.equalTo(containerView).inset(15)
            make.bottom.equalTo(containerView)
        }
        
        verticalStackView.snp.makeConstraints { make in
            make.left.equalTo(photoImageView.snp.right).offset(20)
            make.top.equalTo(contentView).inset(15)
            make.right.equalTo(containerView).inset(15) // Установка правого отступа
            make.bottom.lessThanOrEqualTo(containerView).inset(15)
        }
    }
    
}

extension ProductCell {
    func update(_ product: Pizza) {
        nameLabel.text = product.name
        descriptionLabel.text = product.ingredients
        priceButton.setTitle("from \(product.price) £", for: .normal)
        photoImageView.image = UIImage(named: product.image)
    }
}
