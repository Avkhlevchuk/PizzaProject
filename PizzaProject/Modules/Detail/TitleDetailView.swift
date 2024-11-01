//
//  TitleDetail.swift
//  PizzaProject
//
//  Created by Artem Khlevchuk on 25.10.2024.
//

import UIKit

class TitleDetailView: UIView {
    
    var onCloseButtonTaped: (()->())?
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: .init(18), weight: .bold)
        label.textColor = .black
        label.numberOfLines = 1
        label.text = "Pepperoni Fresh"
        return label
    }()
    
    lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        button.tintColor = .black
        button.transform = CGAffineTransform(scaleX: 1.8, y: 1.8)
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
        self.addBlur(style: .light)
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

public extension UIView {

    @discardableResult
    func addBlur(style: UIBlurEffect.Style = .light) -> UIVisualEffectView {
        let blurEffect = UIBlurEffect(style: style)
        let blurBackground = UIVisualEffectView(effect: blurEffect)
        addSubview(blurBackground)
        blurBackground.translatesAutoresizingMaskIntoConstraints = false
        blurBackground.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        blurBackground.topAnchor.constraint(equalTo: topAnchor).isActive = true
        blurBackground.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        blurBackground.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        return blurBackground
    }
}
