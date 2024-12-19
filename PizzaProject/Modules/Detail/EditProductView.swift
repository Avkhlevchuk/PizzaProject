//
//  EditProductView.swift
//  PizzaProject
//
//  Created by Artem Khlevchuk on 19.12.2024.
//

import UIKit
import SnapKit

final class EditProductView: UIView {
    
    var onEditButtonTapped: (()->())?
    
    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    let editButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Save changes 25 £", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .orange
        button.layer.cornerRadius = 25
        button.addTarget(nil, action: #selector(addButtonTapped), for: .touchUpInside)
        return button
    }()
    
    @objc func addButtonTapped() {
        onEditButtonTapped?()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    func setupViews() {
        self.addBlur(style: .light, alpha: 1)
        self.addSubview(containerView)
        containerView.addSubview(editButton)
    }
    func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.left.right.bottom.equalTo(self)
            make.height.equalTo(100)
        }
        
        editButton.snp.makeConstraints { make in
            make.left.top.right.equalTo(containerView).inset(5)
            make.height.equalTo(50)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: - Update view

extension EditProductView {
    
    func update(_ price: Any) {
        if let priceInt = price as? Int {
            editButton.setTitle("Save changes \(priceInt) £", for: .normal)
            
        } else if let priceDouble = price as? Double {
            editButton.setTitle("Save changes \(Double(priceDouble)) £", for: .normal)
        }
    }
}

