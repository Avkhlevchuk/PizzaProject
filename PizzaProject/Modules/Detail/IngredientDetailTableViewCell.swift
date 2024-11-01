//
//  IngridientDetailTableViewCell.swift
//  PizzaProject
//
//  Created by Artem Khlevchuk on 27.10.2024.
//

import UIKit

class IngredientDetailTableViewCell: UITableViewCell {
    
    static let reuseId = "IngridientDetailTableViewCell"
    
    lazy var containterDescriptionView: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.backgroundColor
        view.layer.cornerRadius = 20
        view.layer.masksToBounds = true
        
        return view
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "German sausages, spicy chorizo, chicken, spicy pepperoni, mozzarella cheese and marinara sauce"
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.textColor = .black
        
        return label
    }()
    
    lazy var removeIngredientsButton: UIButton = {
        let button = UIButton()
        button.setTitle(" ✎ Remove ingredients ", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.backgroundColor = .white
        button.layer.cornerRadius = 15
        return button
    }()
    
    lazy var infoWeightDescriptionButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "info.circle"), for: .normal)
        button.tintColor = .black
        button.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        return button
    }()
    
    lazy var weightLabel: UILabel = {
        let label = UILabel()
        label.text = "470g"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .black
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupContaints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        backgroundColor = .white
        contentView.addSubview(containterDescriptionView)
        
        [descriptionLabel, removeIngredientsButton, infoWeightDescriptionButton, weightLabel].forEach {
            containterDescriptionView.addSubview($0)
        }
    }
    
    func setupContaints() {
        
        containterDescriptionView.snp.makeConstraints { make in
            make.edges.equalTo(contentView).inset(10)
            make.height.equalTo(110)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.left.top.equalTo(containterDescriptionView).offset(10)
            make.right.equalTo(infoWeightDescriptionButton.snp.left)
        }
        
        removeIngredientsButton.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(10)
            make.left.equalTo(descriptionLabel.snp.left)
        }
        
        infoWeightDescriptionButton.snp.makeConstraints { make in
            make.right.top.equalTo(containterDescriptionView).inset(8)
        }
        
        weightLabel.snp.makeConstraints { make in
            make.right.equalTo(infoWeightDescriptionButton.snp.right)
            make.bottom.equalTo(containterDescriptionView).inset(20)
        }
    }
}

//MARK: - Update View
extension IngredientDetailTableViewCell {
    func update(_ product: Pizza) {
        descriptionLabel.text = product.ingredients
    }
}
