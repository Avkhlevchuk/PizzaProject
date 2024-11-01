//
//  IngredientsCollection.swift
//  PizzaProject
//
//  Created by Artem Khlevchuk on 27.10.2024.
//

import UIKit

class ToppingsCollectionCell: UICollectionViewCell {
 
    static let reuseId = "IngredientsCollectionCell"
    
    lazy var imageIngredientView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "halapeno")
        imageView.contentMode = .scaleAspectFill
        let width = UIScreen.main.bounds.width
        imageView.heightAnchor.constraint(equalToConstant: 0.25 * width).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 0.19 * width).isActive = true
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var nameIgredientsLabel: UILabel = {
        let label = UILabel()
        label.text = "Halapeno"
        label.font = .systemFont(ofSize: 14)
        label.textColor = .black
        
        return label
    }()
    
    lazy var priceIngredientLabel: UILabel = {
        let label = UILabel()
        label.text = "100 ₽"
        label.font = .systemFont(ofSize: 14)
        label.textColor = .black
        
        return label
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
        [imageIngredientView, nameIgredientsLabel, priceIngredientLabel].forEach {
            contentView.addSubview($0)
        }
    }
    
    func setupConstraints() {
        imageIngredientView.snp.makeConstraints { make in
            make.left.top.equalTo(contentView).offset(20)
        }
        nameIgredientsLabel.snp.makeConstraints { make in
            make.top.equalTo(imageIngredientView.snp.bottom).offset(5)
            make.centerX.equalTo(contentView)
        }
        priceIngredientLabel.snp.makeConstraints { make in
            make.top.equalTo(nameIgredientsLabel.snp.bottom).offset(8)
            make.centerX.equalTo(contentView)
        }
    }
}
