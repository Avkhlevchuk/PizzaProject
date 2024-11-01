//
//  DetailProductCell.swift
//  PizzaProject
//
//  Created by Artem Khlevchuk on 26.10.2024.
//

import UIKit

class DetailProductViewCell: UITableViewCell {
    
    static let reuseId = "DetailProductView"
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.backGroundBeige
        view.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        view.layer.cornerRadius = 30
        view.layer.masksToBounds = true
        
        return view
    }()
    
    lazy var detailProductImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "peperoni")
        imageView.contentMode = .scaleAspectFill
        let width = UIScreen.main.bounds.width * 0.9
        imageView.heightAnchor.constraint(equalToConstant: width).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: width).isActive = true
        
        return imageView
    }()
    
    let sizePizzaSegmentedControl: CustomizableSegmentControl = {
        let segmentedControl = CustomizableSegmentControl(items: ["25 cm", "30 cm", "35 cm"])
        return segmentedControl
        
    }()
    
    let baseTypePizzaSegmentedControl: CustomizableSegmentControl = {
        let segmentedControl = CustomizableSegmentControl(items: ["Traditional", "Thin"])
        return segmentedControl
        
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
   
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        backgroundColor = .white
        contentView.addSubview(containerView)
        
        [detailProductImageView, sizePizzaSegmentedControl, baseTypePizzaSegmentedControl].forEach {
            containerView.addSubview($0)
        }
    }
    
    func setupConstraints() {
        
        containerView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
            make.height.equalTo(525)
        }
        
        detailProductImageView.snp.makeConstraints { make in
            make.left.equalTo(containerView).inset(25)
            make.top.equalTo(containerView).inset(25)
        }
        
        sizePizzaSegmentedControl.snp.makeConstraints { make in
            make.top.equalTo(detailProductImageView.snp.bottom).offset(20)
            make.left.right.equalTo(containerView).inset(10)
            
        }
        
        baseTypePizzaSegmentedControl.snp.makeConstraints { make in
            make.top.equalTo(sizePizzaSegmentedControl.snp.bottom).offset(10)
            make.left.right.equalTo(containerView).inset(10)
        }
    }
}

//MARK: Update View
extension DetailProductViewCell {
    func update(_ product: Pizza) {
        detailProductImageView.image = UIImage(named: product.image)        
    }
}
