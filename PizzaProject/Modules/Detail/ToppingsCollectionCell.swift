//
//  IngredientsCollection.swift
//  PizzaProject
//
//  Created by Artem Khlevchuk on 27.10.2024.
//

import UIKit

final class ToppingsCollectionCell: UICollectionViewCell {
 
    static let reuseId = "IngredientsCollectionCell"
    
    lazy var imageToppingView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "halapeno")
        imageView.contentMode = .scaleAspectFill
        let width = UIScreen.main.bounds.width
        imageView.heightAnchor.constraint(equalToConstant: 0.25 * width).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 0.19 * width).isActive = true
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var nameToppingLabel: UILabel = {
        let label = UILabel()
        label.text = "Halapeno"
        label.font = .systemFont(ofSize: 14)
        label.textColor = .black
        
        return label
    }()
    
    lazy var priceToppingLabel: UILabel = {
        let label = UILabel()
        label.text = "100 ₽"
        label.font = .systemFont(ofSize: 14)
        label.textColor = .black
        
        return label
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
        [imageToppingView, nameToppingLabel, priceToppingLabel].forEach {
            contentView.addSubview($0)
        }
    }
    
    func setupConstraints() {
        imageToppingView.snp.makeConstraints { make in
            make.left.top.equalTo(contentView).offset(20)
        }
        nameToppingLabel.snp.makeConstraints { make in
            make.top.equalTo(imageToppingView.snp.bottom).offset(5)
            make.centerX.equalTo(contentView)
        }
        priceToppingLabel.snp.makeConstraints { make in
            make.top.equalTo(nameToppingLabel.snp.bottom).offset(8)
            make.centerX.equalTo(contentView)
        }
    }
}

extension ToppingsCollectionCell {
    func update(topping: Toppings) {
        imageToppingView.image = UIImage(named: topping.name)
        nameToppingLabel.text = topping.name
        priceToppingLabel.text = topping.price
    }
}
