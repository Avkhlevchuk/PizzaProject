//
//  BannerCollectrionCell.swift
//  PizzaProject
//
//  Created by Artem Khlevchuk on 27.09.2024.
//

import UIKit

class BannerCollectionCell: UICollectionViewCell {
    
    static let reuseId = "BannerCollectionCell"
    
    let typeFoodLabel: UILabel = {
        $0.font = .boldSystemFont(ofSize: 14)
        $0.textColor = .gray
        $0.text = "Римские пиццы"
        return $0
    }(UILabel())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
//        contentView.backgroundColor = .blue
        contentView.addSubview(typeFoodLabel)
    }
    
    func setupConstraints() {
        typeFoodLabel.snp.makeConstraints { make in
            make.top.bottom.equalTo(contentView)
            make.left.equalTo(contentView).inset(20)
        }
    }
}
