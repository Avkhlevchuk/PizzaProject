//
//  BannerCollectrionCell.swift
//  PizzaProject
//
//  Created by Artem Khlevchuk on 27.09.2024.
//

import UIKit

final class CategoryCollectionCell: UICollectionViewCell {
    
    var onButtonTapped: (()->())?
        
    let typeFoodLabel: UIButton = {
        $0.setTitle("Римские пиццы", for: .normal)
        $0.setTitleColor(.gray, for: .normal)
        $0.titleLabel?.font = .boldSystemFont(ofSize: 14)
        $0.addTarget(nil, action: #selector(buttonTapped), for: .touchUpInside)
        return $0
    }(UIButton())
    
    @objc func buttonTapped() {
        onButtonTapped?()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        contentView.addSubview(typeFoodLabel)
    }
    
    func setupConstraints() {
        typeFoodLabel.snp.makeConstraints { make in
            make.top.bottom.equalTo(contentView)
            make.right.equalTo(contentView)
            make.left.equalTo(contentView).inset(15)
        }
    }
}

//MARK: - Update View
extension CategoryCollectionCell {
    func update(_ filter: String) {
        typeFoodLabel.setTitle("\(filter)", for: .normal)
    }
    
    func setSelected(_ isSelected: Bool) {
        if isSelected {
            typeFoodLabel.setTitleColor(.black, for: .normal)
        } else {
            typeFoodLabel.setTitleColor(.gray, for: .normal)
        }
    }
}
