//
//  RemoveIngredientsCell.swift
//  PizzaProject
//
//  Created by Artem Khlevchuk on 18.11.2024.
//

import UIKit
import SnapKit

class RemoveIngredientsCell: UICollectionViewCell {
    
    var onRemoveButtonTapped: (()->())?
    
    lazy var ingredientLabel: UILabel = {
        let label = UILabel()
        label.text = "Tomatoes"
        label.font = .systemFont(ofSize: 15)
        label.textColor = .orange
        label.numberOfLines = 1
        return label
    }()
    
    lazy var iconCross: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal )
        button.tintColor = .orange
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
        setupBorder()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        contentView.addSubview(iconCross)
        contentView.addSubview(ingredientLabel)
    }
    
    func setupConstraints() {
        iconCross.snp.makeConstraints { make in
            make.left.equalTo(contentView).inset(10)
            make.top.bottom.equalTo(contentView).inset(10)
            make.height.width.equalTo(10)
        }
        ingredientLabel.snp.makeConstraints { make in
            make.left.equalTo(iconCross.snp.right).offset(2)
            make.top.bottom.equalTo(contentView).inset(7)
            make.right.equalTo(contentView).inset(7)
        }
    }
    
    private func setupBorder() {
        contentView.layer.borderWidth = 0.8 // Толщина рамки
         contentView.layer.borderColor = UIColor.orange.cgColor // Цвет рамки
         contentView.layer.cornerRadius = 8 // Радиус углов
         contentView.clipsToBounds = true // Обрезка содержимого за границами
     }
}

//MARK: - Event Hanbler

extension RemoveIngredientsCell {
    func bind(ingredients: IngredientStates) {
      
        if ingredients.ingredient.isRemovable {
            iconCross.tintColor = Colors.orange
            ingredientLabel.textColor = Colors.orange
            contentView.layer.borderColor = Colors.orange.cgColor
        } else {
            iconCross.tintColor = .gray
            ingredientLabel.textColor = .gray
            contentView.layer.borderColor = UIColor.lightGray.cgColor
        }
        ingredientLabel.text = ingredients.ingredient.name
    }
    
    func removeIngredient() {
        
        UIView.animate(withDuration: 0.3, delay: 0.2, options: .curveEaseInOut, animations: { [weak self] in
            guard let self = self else { return }
            
            self.iconCross.isHidden = true
            
            self.ingredientLabel.applyStrikethrought()
            
            self.ingredientLabel.snp.remakeConstraints { make in
                make.left.equalTo(self.contentView).inset(7)
                make.top.bottom.equalTo(self.contentView).inset(7)
                make.right.equalTo(self.contentView).inset(7)
            }
        })
        
        onRemoveButtonTapped?()
    }
    
    func addRemovedIngredient() {
        
            iconCross.isHidden = false
        
            ingredientLabel.removeStrikeThrought()
                
            iconCross.snp.remakeConstraints { make in
                make.left.equalTo(contentView).inset(10)
                make.top.bottom.equalTo(contentView).inset(10)
                make.height.width.equalTo(10)
            }
            ingredientLabel.snp.remakeConstraints { make in
                make.left.equalTo(iconCross.snp.right).offset(2)
                make.top.bottom.equalTo(contentView).inset(7)
                make.right.equalTo(contentView).inset(7)
            }
            
            self.contentView.layoutIfNeeded()
        
        onRemoveButtonTapped?()
    }
}
