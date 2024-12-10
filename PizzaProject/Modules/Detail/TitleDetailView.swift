//
//  TitleDetail.swift
//  PizzaProject
//
//  Created by Artem Khlevchuk on 25.10.2024.
//

import UIKit

final class TitleDetailView: UIView {
    
    var onCloseButtonTaped: (()->())?
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: .init(19), weight: .bold)
        label.textColor = .black
        label.numberOfLines = 1
        label.text = "Pepperoni Fresh"
        return label
    }()
    
    lazy var closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        button.tintColor = .black
        button.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        button.addTarget(nil , action: #selector(closeButtonTaped),for: .touchUpInside)
        return button
    }()
    
    @objc func closeButtonTaped() {
        onCloseButtonTaped?()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        self.addBlur(style: .light, alpha: 0.5)
        backgroundColor = .clear
        [titleLabel, closeButton].forEach {
            addSubview($0)
        }
    }
    
    func setupConstraints() {
        closeButton.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(20)
            make.top.equalToSuperview().inset(70)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(70)
            make.centerX.equalToSuperview()
        }
    }
}
//MARK: - Update View

extension TitleDetailView {
    func update(_ product: Pizza) {
        titleLabel.text = product.name
    }
    
    func changeAlpha(alha: CGFloat) {
        self.addBlur(style: .light, alpha: alha)
    }
}
