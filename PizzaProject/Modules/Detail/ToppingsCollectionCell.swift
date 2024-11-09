//
//  IngredientsCollection.swift
//  PizzaProject
//
//  Created by Artem Khlevchuk on 27.10.2024.
//

import UIKit

final class ToppingsCollectionCell: UICollectionViewCell {
 
    static let reuseId = "IngredientsCollectionCell"
    
    var isSelectedCell: Bool = true {
        didSet {
            containerSelectedView.backgroundColor = isSelectedCell ? .white : Colors.backgroundColor
            selectedToppingButton.isHidden = isSelectedCell ? true : false
        }
    }
    
    lazy var containerSelectedView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 25
        view.clipsToBounds = true
        return view
    }()
    
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
    
    lazy var selectedToppingButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
        button.tintColor = .orange
        button.isHidden = true
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
        
        contentView.addSubview(containerSelectedView)
        
        [imageToppingView, nameToppingLabel, priceToppingLabel, selectedToppingButton].forEach {
            containerSelectedView.addSubview($0)
        }
    }
    
    func setupConstraints() {
        
        containerSelectedView.snp.makeConstraints { make in
            make.edges.equalTo(contentView).offset(5)
        }
        
        imageToppingView.snp.makeConstraints { make in
            make.left.top.equalTo(containerSelectedView).offset(20)
        }
        nameToppingLabel.snp.makeConstraints { make in
            make.top.equalTo(imageToppingView.snp.bottom).offset(5)
            make.centerX.equalTo(containerSelectedView)
        }
        priceToppingLabel.snp.makeConstraints { make in
            make.top.equalTo(nameToppingLabel.snp.bottom).offset(8)
            make.centerX.equalTo(containerSelectedView)
        }
        selectedToppingButton.snp.makeConstraints { make in
            make.top.right.equalTo(containerSelectedView).inset(5)
            make.height.width.equalTo(30).priority(.required)
        }
    }
}

extension ToppingsCollectionCell {
    func update(topping: Toppings) {
        imageToppingView.image = UIImage(named: topping.name)
        nameToppingLabel.text = topping.name
        priceToppingLabel.text = "\(topping.price) £"
    }
}
