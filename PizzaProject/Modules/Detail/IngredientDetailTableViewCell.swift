//
//  IngridientDetailTableViewCell.swift
//  PizzaProject
//
//  Created by Artem Khlevchuk on 27.10.2024.
//

import UIKit

final class IngredientDetailTableViewCell: UITableViewCell {
        
    var onInfoButtonTapped: ((UIButton)->())?
    
    var onRemoveIngredientsButtonTapped: (()->())?

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
        let button = UIButton(type: .system)
        button.setTitle(" ✎ Remove ingredients ", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.backgroundColor = .white
        button.layer.cornerRadius = 15
        button.addTarget(nil, action: #selector(removeIngredientsTapped), for: .touchUpInside)
        return button
    }()
    
    @objc private func removeIngredientsTapped() {
        onRemoveIngredientsButtonTapped?()
    }
    
    lazy var infoWeightDescriptionButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "info.circle"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(infoButtonTapped), for: .touchUpInside)
        return button
    }()
    
    @objc private func infoButtonTapped(_ sender: UIButton) {
        onInfoButtonTapped?(sender)

    }
    
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
            make.left.top.equalTo(containterDescriptionView).offset(15)
            make.right.equalTo(infoWeightDescriptionButton).inset(30)
        }
        
        removeIngredientsButton.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(10)
            make.left.equalTo(descriptionLabel.snp.left)
        }
        
        infoWeightDescriptionButton.snp.makeConstraints { make in
            make.top.equalTo(containterDescriptionView).inset(12)
            make.right.equalTo(containterDescriptionView).inset(15)
            make.height.width.equalTo(24)
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
        descriptionLabel.text = product.ingredientsList
    }
}

//MARK: - ToolBar

extension IngredientDetailTableViewCell: UIToolTipInteractionDelegate {
    
    func toolTipInteraction(_ interaction: UIToolTipInteraction, configurationAt point: CGPoint) -> UIToolTipConfiguration? {

            let configuration: UIToolTipConfiguration?
            if let accessibilityName = backgroundColor?.accessibilityName {
                configuration = UIToolTipConfiguration(toolTip: "The color is \(accessibilityName).")
            } else {
                configuration = nil
            }
            
            return configuration
        }
}
