//
//  ShortBannerCollectionCell.swift
//  PizzaProject
//
//  Created by Artem Khlevchuk on 14.10.2024.
//

import UIKit
import SnapKit

class ShortBannerCollectionCell: UICollectionViewCell {
    
    static let reuseId = "ShortBannerCollectionCell"
 
    lazy var containerView: UIView = {
       let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "pepperoni")
        imageView.contentMode = .scaleAspectFill
        let width = UIScreen.main.bounds.width
        imageView.heightAnchor.constraint(equalToConstant: 0.25 * width).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 0.25 * width).isActive = true
        
        return imageView
    }()
    
    lazy var verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 10
        return stackView
    }()
    
    var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Пеперони"
        label.textColor = .black
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 15)
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        contentView.addSubview(containerView)
        
        [imageView, verticalStackView].forEach {
            containerView.addSubview($0)
        }
        
        [nameLabel, priceButton].forEach {
            verticalStackView.addArrangedSubview($0)
        }
    }
    
    func setupConstraints() {
        
        containerView.snp.makeConstraints { make in
            make.edges.equalTo(containerView)
            
        }
        
        imageView.snp.makeConstraints { make in
            make.top.equalTo(contentView).inset(10)
            make.left.equalTo(contentView).inset(10)
            
        }
        
        verticalStackView.snp.makeConstraints { make in
            //FIXME: - error about constraints
//            make.width.equalTo(120)
//            make.height.greaterThanOrEqualTo(50)
            make.centerY.equalTo(contentView)
            make.left.equalTo(imageView.snp.right).offset(5)
            make.right.equalTo(contentView).inset(10)
        }
        
    }
}

//MARK: - Update view

extension ShortBannerCollectionCell {
    func update(_ product: Pizza) {
        imageView.image = UIImage(named: product.image)
        nameLabel.text = product.name
        priceButton.setTitle("от \(product.price) ₽", for: .normal)
    }
}
