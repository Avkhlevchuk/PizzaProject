//
//  ToppingInfoPopoverViewController.swift
//  PizzaProject
//
//  Created by Artem Khlevchuk on 06.11.2024.
//

import UIKit

class ToppingInfoPopoverViewController: UIViewController {
    
    lazy var container: UIView = {
        let container = UIView()
        container.backgroundColor = .black
        return container
    }()
    
    lazy var containerForTitle: UIView = {
        let container = UIView()
        return container
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Sweet Chilli shrimp"
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .white
        return label
    }()
    
    lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Nutrition fats (per 100 g)"
        label.font = .systemFont(ofSize: 15)
        label.textColor = .white
        return label
    }()
    
    lazy var containerForWeight: UIView = {
        let container = UIView()
        return container
    }()
    
    lazy var weightLabel: UILabel = {
        let label = UILabel()
        label.text = "Weight"
        label.font = .systemFont(ofSize: 15)
        label.textColor = .white
        return label
    }()
    
    lazy var weightValueLabel: UILabel = {
        let label = UILabel()
        label.text = "100 g"
        label.font = .systemFont(ofSize: 15)
        label.textColor = .white
        return label
    }()
    
    lazy var containerForCalories: UIView = {
        let container = UIView()
        return container
    }()
    
    lazy var caloriesLabel: UILabel = {
        let label = UILabel()
        label.text = "Calories"
        label.font = .systemFont(ofSize: 15)
        label.textColor = .white
        return label
    }()
    
    lazy var caloriesValueLabel: UILabel = {
        let label = UILabel()
        label.text = "250 kcal"
        label.font = .systemFont(ofSize: 15)
        label.textColor = .white
        return label
    }()
    
    lazy var containerForProtein: UIView = {
        let container = UIView()
        return container
    }()
    
    lazy var proteinLabel: UILabel = {
        let label = UILabel()
        label.text = "Protein"
        label.font = .systemFont(ofSize: 15)
        label.textColor = .white
        return label
    }()
    
    lazy var proteinValueLabel: UILabel = {
        let label = UILabel()
        label.text = "10 g"
        label.font = .systemFont(ofSize: 15)
        label.textColor = .white
        return label
    }()
    
    lazy var containerForFats: UIView = {
        let container = UIView()
        return container
    }()
    
    lazy var fatsLabel: UILabel = {
        let label = UILabel()
        label.text = "Fats"
        label.font = .systemFont(ofSize: 15)
        label.textColor = .white
        return label
    }()
    
    lazy var fatsValueLabel: UILabel = {
        let label = UILabel()
        label.text = "15 g"
        label.font = .systemFont(ofSize: 15)
        label.textColor = .white
        return label
    }()
    
    lazy var containerForCarbohydrates: UIView = {
        let container = UIView()
        return container
    }()
    
    lazy var carbohydratesLabel: UILabel = {
        let label = UILabel()
        label.text = "Carbohydrates"
        label.font = .systemFont(ofSize: 15)
        label.textColor = .white
        return label
    }()
    
    lazy var carbohydratesValueLabel: UILabel = {
        let label = UILabel()
        label.text = "20 g"
        label.font = .systemFont(ofSize: 15)
        label.textColor = .white
        return label
    }()
    
    lazy var containerForMayContainAndAllergies: UIView = {
        let container = UIView()
        return container
    }()
    
    lazy var mayContainLabel: UILabel = {
        let label = UILabel()
        label.text = "May contain"
        label.font = .systemFont(ofSize: 15)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    lazy var allergiesLabel: UILabel = {
        let label = UILabel()
        label.text = "allergies"
        label.font = .systemFont(ofSize: 15)
        label.textColor = .white
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
        
    func setupViews() {
        view.backgroundColor = .black
        view.addSubview(container)
        
        [containerForTitle, containerForWeight, containerForCalories, containerForProtein, containerForFats, containerForCarbohydrates, containerForMayContainAndAllergies].forEach {
            container.addSubview($0)
        }
        
        [titleLabel, subtitleLabel].forEach {
            containerForTitle.addSubview($0)
        }
        
        [weightLabel, weightValueLabel].forEach {
            containerForWeight.addSubview($0)
        }
        [caloriesLabel, caloriesValueLabel].forEach {
            containerForCalories.addSubview($0)
        }
        [proteinLabel, proteinValueLabel].forEach {
            containerForProtein.addSubview($0)
        }
        [fatsLabel, fatsValueLabel].forEach {
            containerForFats.addSubview($0)
        }
        [carbohydratesLabel, carbohydratesValueLabel].forEach {
            containerForCarbohydrates.addSubview($0)
        }
        
        [mayContainLabel, allergiesLabel].forEach {
            containerForMayContainAndAllergies.addSubview($0)
        }
    }
    
    func setupConstraints() {
        
        container.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview().priority(.low)
            make.width.equalTo(ScreenSize.width * 0.8)
        }
        
        containerForTitle.snp.makeConstraints { make in
            make.left.right.top.equalTo(container)
            make.height.equalTo(60)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.left.top.equalTo(containerForTitle).inset(15)
        }
        subtitleLabel.snp.makeConstraints { make in
            make.left.equalTo(titleLabel.snp.left)
            make.top.equalTo(titleLabel.snp.bottom).offset(3)
        }
        
        containerForWeight.snp.makeConstraints { make in
            make.left.right.equalTo(container)
            make.top.equalTo(containerForTitle.snp.bottom).offset(10)
            make.height.equalTo(25)
        }
        weightLabel.snp.makeConstraints { make in
            make.left.equalTo(titleLabel.snp.left)
            make.top.equalTo(containerForWeight.snp.top)
        }
        weightValueLabel.snp.makeConstraints { make in
            make.right.equalTo(containerForWeight.snp.right).inset(30)
            make.top.equalTo(containerForWeight.snp.top)
        }
        
        containerForCalories.snp.makeConstraints { make in
            make.left.right.equalTo(container)
            make.top.equalTo(containerForWeight.snp.bottom).offset(5)
            make.height.equalTo(25)
        }
        caloriesLabel.snp.makeConstraints { make in
            make.left.equalTo(titleLabel.snp.left)
            make.top.equalTo(containerForCalories.snp.top)
        }
        caloriesValueLabel.snp.makeConstraints { make in
            make.right.equalTo(containerForCalories.snp.right).inset(30)
            make.top.equalTo(containerForCalories.snp.top)
        }
        
        containerForProtein.snp.makeConstraints { make in
            make.left.right.equalTo(container)
            make.top.equalTo(containerForCalories.snp.bottom).offset(5)
            make.height.equalTo(25)
        }
        proteinLabel.snp.makeConstraints { make in
            make.left.equalTo(titleLabel.snp.left)
            make.top.equalTo(containerForProtein.snp.top)
        }
        proteinValueLabel.snp.makeConstraints { make in
            make.right.equalTo(containerForProtein.snp.right).inset(30)
            make.top.equalTo(containerForProtein.snp.top)
        }
        
        containerForFats.snp.makeConstraints { make in
            make.left.right.equalTo(container)
            make.top.equalTo(containerForProtein.snp.bottom).offset(5)
            make.height.equalTo(25)
        }
        fatsLabel.snp.makeConstraints { make in
            make.left.equalTo(titleLabel.snp.left)
            make.top.equalTo(containerForFats.snp.top)
        }
        fatsValueLabel.snp.makeConstraints { make in
            make.right.equalTo(containerForFats.snp.right).inset(30)
            make.top.equalTo(containerForFats.snp.top)
        }
        
        containerForCarbohydrates.snp.makeConstraints { make in
            make.left.right.equalTo(container)
            make.top.equalTo(containerForFats.snp.bottom).offset(5)
            make.height.equalTo(25)
        }
        carbohydratesLabel.snp.makeConstraints { make in
            make.left.equalTo(titleLabel.snp.left)
            make.top.equalTo(containerForCarbohydrates.snp.top)
        }
        carbohydratesValueLabel.snp.makeConstraints { make in
            make.right.equalTo(containerForCarbohydrates.snp.right).inset(30)
            make.top.equalTo(containerForCarbohydrates.snp.top)
        }
        containerForMayContainAndAllergies.snp.makeConstraints { make in
            make.left.equalTo(container)
            make.right.equalTo(container.snp.right)
            make.top.equalTo(containerForCarbohydrates.snp.bottom).offset(5)
            make.bottom.equalTo(view.snp.bottom)
//            make.height.equalTo(75)
        }
        
        mayContainLabel.snp.makeConstraints { make in
            make.top.equalTo(containerForMayContainAndAllergies.snp.top).inset(5)
            make.left.equalTo(titleLabel.snp.left)
            make.right.equalTo(containerForMayContainAndAllergies.snp.right).inset(45)
        }
        
        allergiesLabel.snp.makeConstraints { make in
            make.top.equalTo(mayContainLabel.snp.bottom).offset(2)
            make.left.equalTo(titleLabel.snp.left)
        }
    }
    
}

//MARK: Events hendler

extension ToppingInfoPopoverViewController {
    func update(nutritionValue: NutritionValue) {
        titleLabel.text = nutritionValue.namePizza
        weightValueLabel.text = "\(nutritionValue.weight) g"
        caloriesValueLabel.text = "\(nutritionValue.calories) kcal"
        proteinValueLabel.text = "\(nutritionValue.protein) g"
        fatsValueLabel.text = "\(nutritionValue.fats) g"
        carbohydratesValueLabel.text = "\(nutritionValue.carbohydrates) g"
        mayContainLabel.text = "May contain: \(nutritionValue.mayContain)"
        allergiesLabel.text = "Allergies: \(nutritionValue.allergens)"
    }
}
