//
//  DetailProductCell.swift
//  PizzaProject
//
//  Created by Artem Khlevchuk on 26.10.2024.
//

import UIKit

final class DetailProductViewCell: UITableViewCell {
    
    static let reuseId = "DetailProductView"
    
    var onSegmentControlSizeTapped: ((String)->())?
    var onSegmentControlBaseTapped: ((String)->())?
    
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
    
    @objc func sizePizzaChanged() {
        let selectedIndex = sizePizzaSegmentedControl.selectedSegmentIndex
        var namePizzaSize = ""
        switch selectedIndex {
        case 0:
            namePizzaSize = "small"
        case 1:
            namePizzaSize = "medium"
        case 2:
            namePizzaSize = "large"
        default:
            namePizzaSize = "medium"
        }
        onSegmentControlSizeTapped?(namePizzaSize)
        
        }
    @objc func baseTypeChanged() {
            let selectedIndex = baseTypePizzaSegmentedControl.selectedSegmentIndex
        var namePizzaBaseType = ""
        switch selectedIndex {
        case 0:
            namePizzaBaseType = "traditional"
        case 1:
            namePizzaBaseType = "thin"
        default:
            namePizzaBaseType = "traditional"
        }
        onSegmentControlBaseTapped?(namePizzaBaseType)
        }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
        setupSegmentControlActions()
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
            make.top.equalTo(containerView).inset(25)
            make.centerX.equalTo(containerView)
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
    
    func setupSegmentControlActions() {
            sizePizzaSegmentedControl.addTarget(self, action: #selector(sizePizzaChanged), for: .valueChanged)
            baseTypePizzaSegmentedControl.addTarget(self, action: #selector(baseTypeChanged), for: .valueChanged)
        }
}

//MARK: Update View
extension DetailProductViewCell {
    func update(_ product: Pizza) {
        detailProductImageView.image = UIImage(named: product.image)        
    }
}
