//
//  CartCell.swift
//  PizzaProject
//
//  Created by Artem Khlevchuk on 25.11.2024.
//

import UIKit

class CartCell: UITableViewCell {
    
    var onIncrementButtonTapped: (()->())?
    var onDecrementButtonTapped: (()->())?
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    var verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        return stackView
    }()
    
    var photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "peperoni")
        imageView.contentMode = .scaleAspectFit
        let width = UIScreen.main.bounds.width
        imageView.heightAnchor.constraint(equalToConstant: 0.17 * width).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 0.17 * width).isActive = true
        
        return imageView
    }()
    
    var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Pepperoni"
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Medium 30 cm, tradutional dough"
        label.textColor = .black
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    var containerPriceAndChangeView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    var priceForPizzaLabel: UILabel = {
        let label = UILabel()
        label.text = "50 £"
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    var changeLabel: UILabel = {
        let label = UILabel()
        label.text = "Change"
        label.textColor = Colors.darkOrange
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    var spacer = UIView()
    
    var decrementButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("-", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.addTarget(nil, action: #selector(decrementButtonTapped), for: .touchUpInside)
        return button
    }()
    
    @objc func decrementButtonTapped() {
        onDecrementButtonTapped?()
    }
    
    var incrementButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("+", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.addTarget(nil, action: #selector(incrementButtonTapped), for: .touchUpInside)
        return button
    }()
    
    @objc func incrementButtonTapped() {
        onIncrementButtonTapped?()
    }
    
    
    var countPizzaLabel: UILabel = {
        let label = UILabel()
        label.text = "1"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textColor = .black
        return label
    }()
    
    var customStepperView: UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = Colors.backgroundColor
        stackView.layer.cornerRadius = 13
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        
        [containerView].forEach {
            contentView.addSubview($0)
        }
        
        [photoImageView, containerPriceAndChangeView, verticalStackView].forEach {
            containerView.addSubview($0)
        }
        
        [nameLabel, descriptionLabel].forEach {
            verticalStackView.addArrangedSubview($0)
        }
        
        [priceForPizzaLabel, changeLabel, customStepperView].forEach {
            containerPriceAndChangeView.addSubview($0)
        }
        
        [decrementButton, countPizzaLabel, incrementButton].forEach {
            customStepperView.addArrangedSubview($0)
        }
    }
    
    func setupConstraints() {
        
        containerView.snp.makeConstraints { make in
            make.left.right.equalTo(contentView)
            make.top.equalTo(contentView)
            make.bottom.equalTo(contentView.snp.bottom)
            
        }
        
        photoImageView.snp.makeConstraints { make in
            make.left.top.equalTo(containerView).inset(15)
            //            make.bottom.lessThanOrEqualTo(containerView).inset(15)
            make.bottom.equalTo(containerPriceAndChangeView.snp.top)
            make.width.equalTo(photoImageView.snp.height)
        }
        
        verticalStackView.snp.makeConstraints { make in
            make.left.equalTo(photoImageView.snp.right).offset(20)
            make.top.equalTo(contentView).inset(15)
            make.right.equalTo(containerView).inset(15)
//            make.bottom.equalTo(containerPriceAndChangeView.snp.top)
//            make.bottom.lessThanOrEqualTo(containerPriceAndChangeView.snp.bottom)
            
        }
        
        nameLabel.snp.makeConstraints { make in
            make.left.top.equalTo(verticalStackView)
            make.bottom.equalTo(descriptionLabel.snp.top)
        }
        
        descriptionLabel.snp.makeConstraints { make in
               make.top.equalTo(nameLabel.snp.bottom)
               make.left.right.equalTo(verticalStackView)
               make.bottom.lessThanOrEqualTo(verticalStackView.snp.bottom)
            
        }
        
        containerPriceAndChangeView.snp.makeConstraints { make in
            make.left.right.equalTo(containerView)
            make.height.equalTo(40)
            make.top.equalTo(photoImageView.snp.bottom)
            make.bottom.equalTo(containerView.snp.bottom)
        }
        
        priceForPizzaLabel.snp.makeConstraints { make in
            make.centerY.equalTo(containerPriceAndChangeView)
            make.left.equalTo(containerPriceAndChangeView.snp.left).inset(15)
        }
        
        changeLabel.snp.makeConstraints { make in
            make.centerY.equalTo(containerPriceAndChangeView)
            make.right.equalTo(customStepperView.snp.left).offset(-10)
        }
        
        customStepperView.snp.makeConstraints { make in
            make.right.equalTo(containerPriceAndChangeView.snp.right).inset(15)
            make.centerY.equalTo(containerPriceAndChangeView)
            make.width.equalTo(90)
            make.height.equalTo(27)
        }
    }
}

//MARK: - Event handler

extension CartCell {
    func bind(order: Order) {
        
        var addIngredientsDescription: String = ""
        var removedIngredientsDescription: String = ""
        
        let sum = (order.priceForPizza + order.sumForToppings) * Double(order.count)
        priceForPizzaLabel.text = "\(sum) £"
        
        nameLabel.text = order.product.name
        photoImageView.image = UIImage(named: order.product.image)
        
        if !order.toppings.isEmpty {
            
            addIngredientsDescription = "+ "
            
            for (index, ingredient) in order.toppings.enumerated() {
                
                let ingedientLowercased = ingredient.name.lowercased()
                
                if index == order.toppings.count - 1 {
                    addIngredientsDescription += "\(ingedientLowercased)"
                } else {
                    addIngredientsDescription += "\(ingedientLowercased), "
                }
            }
        }
        
        if !order.removedIngredients.isEmpty {
            removedIngredientsDescription = "- "
            var removedIngredientsArray = [IngredientStates]()
            
            for removedIngredient in order.removedIngredients {
                
                if removedIngredient.isRemoved {
                    removedIngredientsArray.append(removedIngredient)
                }
                
            }
            for (index, removedIngredient) in removedIngredientsArray.enumerated() {
                if removedIngredientsArray.count - 1 == index {
                    let removedIngredientsLowercased = removedIngredient.ingredient.name.lowercased()
                    removedIngredientsDescription += "\(removedIngredientsLowercased)"
                } else {
                    let removedIngredientsLowercased = removedIngredient.ingredient.name.lowercased()
                    removedIngredientsDescription += "\(removedIngredientsLowercased), "
                }
            }
            
        }
        
        var titleDescription: String = ""
        
        switch order.sizePizza {
        case "small":
            titleDescription = "Small 20 cm"
        case "medium":
            titleDescription = "Medium 25 cm"
        case "large":
            titleDescription = "Large 30 cm"
        default:
            break
        }
        
        switch order.typeBasePizza {
        case "thin":
            titleDescription += ", thin dough"
        case "traditional":
            titleDescription += ", traditional dough"
        default:
            break
        }
        
        let totalDescription = titleDescription + "\n" + addIngredientsDescription + "\n" + removedIngredientsDescription
        
        descriptionLabel.text = totalDescription
        
        countPizzaLabel.text = "\(order.count)"
        
    }
}
