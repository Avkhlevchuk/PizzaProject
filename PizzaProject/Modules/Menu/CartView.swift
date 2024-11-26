//
//  CartView.swift
//  PizzaProject
//
//  Created by Artem Khlevchuk on 22.11.2024.
//

import UIKit

class CartView: UIView {
    
    var onCartButtonTapped: (()->())?
    
    lazy var cartButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("899 ₽", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        button.backgroundColor = Colors.orange
        button.tintColor = .white
        button.layer.cornerRadius = 22
        button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        button.clipsToBounds = true
        button.addTarget(nil, action: #selector(cartButtonTapped), for: .touchUpInside)
        let icon = UIImage(systemName: "cart.fill")?.withRenderingMode(.alwaysTemplate)
        button.setImage(icon, for: .normal)
        
        button.imageEdgeInsets = UIEdgeInsets(top: 3, left: -10, bottom: 4, right: 0)
        button.imageView?.contentMode = .scaleAspectFit
        
        return button
    }()
    
    @objc func cartButtonTapped() {
        onCartButtonTapped?()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        self.addSubview(cartButton)
        cartButton.isHidden = true
    }
    
    func setupConstrains() {
        cartButton.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    func bind(totalPrice: Double) {
        if totalPrice == 0.0 {
            cartButton.isHidden = true
        } else {
            cartButton.setTitle("\(totalPrice) £", for: .normal)
            cartButton.isHidden = false
        }
    }
}
