//
//  AddProductView.swift
//  PizzaProject
//
//  Created by Artem Khlevchuk on 05.11.2024.
//

import UIKit

final class AddProductView: UIView {
    
    let recordArchiver = RecordArchiver.shared
    
    var onAddButtonTapped: (()->())?
    
    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    let addButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Add to cart from 25£", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .orange
        button.layer.cornerRadius = 25
        button.addTarget(nil, action: #selector(addButtonTapped), for: .touchUpInside)
        return button
    }()
    
    @objc func addButtonTapped() {
        onAddButtonTapped?()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    func setupViews() {
        self.addBlur(style: .light, alpha: 1)
        self.addSubview(containerView)
        containerView.addSubview(addButton)
    }
    func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.left.right.bottom.equalTo(self)
            make.height.equalTo(100)
        }
        
        addButton.snp.makeConstraints { make in
            make.left.top.right.equalTo(containerView).inset(5)
            make.height.equalTo(50)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: - Update view

extension AddProductView {
    
    func update(_ price: Any) {
        if let priceInt = price as? Int {
            addButton.setTitle("Add to cart from \(priceInt) £", for: .normal)
            
        } else if let priceDouble = price as? Double {
            addButton.setTitle("Add to cart from \(Double(priceDouble)) £", for: .normal)
        }
    }
}

//MARK: - External

extension AddProductView {
    
    func addToCard(product: Pizza, toppings: [Toppings], sumForToppings: Double, priceForPizza: Double, typeBasePizza: String) {
        let order = Order(product: product, count: 1, toppings: toppings, sumForToppings: sumForToppings, priceForPizza: priceForPizza, typeBasePizza: typeBasePizza)

        recordArchiver.save(order: [order])
    }
    
}
