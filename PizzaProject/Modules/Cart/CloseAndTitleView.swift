//
//  CloseAndTitleView.swift
//  PizzaProject
//
//  Created by Artem Khlevchuk on 25.11.2024.
//

import UIKit
import SnapKit

class CloseAndTitleView: UIView {
    
    var onCloseButtonTapped: (()->())?
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Cart"
        label.font = .systemFont(ofSize: .init(17), weight: .semibold)
        return label
    }()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Close", for: .normal)
        button.addTarget(nil, action: #selector(closeButtonTapped), for: .touchUpInside)
        button.tintColor = Colors.orange
        return button
    }()
    
    @objc func closeButtonTapped() {
        onCloseButtonTapped?()
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
        [closeButton, titleLabel].forEach {
            self.addSubview($0)
        }
        self.backgroundColor = .white
    }
    
    func setupConstraints() {
        closeButton.snp.makeConstraints { make in
            make.left.equalTo(self.snp.left).inset(15)
            make.top.equalTo(self.snp.top).inset(15)
        }
        titleLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(self)
        }
    }
}
