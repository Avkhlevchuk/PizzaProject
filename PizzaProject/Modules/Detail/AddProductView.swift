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
        self.addBlur(style: .light)
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
    
    func update(_ price: Int) {
        addButton.setTitle("Add to cart from \(price) £", for: .normal)
    }
}


//MARK: - External

extension AddProductView {
    
    func addToCard(product: Pizza) {
        let order = Order(product: product, count: 1, toppings: [])

        recordArchiver.save(order: [order])
    }
}
