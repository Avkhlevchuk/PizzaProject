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
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Sweet Chilli shrimp"
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .white
        label.backgroundColor = .black
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
    
    override func viewDidLayoutSubviews() {
        container.frame = view.bounds
    }
    
    func setupViews() {
        view.addSubview(container)
        
        [titleLabel, subtitleLabel, containerForWeight, containerForCalories, containerForProtein, containerForFats, containerForCarbohydrates, containerForMayContainAndAllergies].forEach {
            container.addSubview($0)
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
        titleLabel.snp.makeConstraints { make in
            make.left.top.equalTo(view).inset(15)
        }
        subtitleLabel.snp.makeConstraints { make in
            make.left.equalTo(titleLabel.snp.left)
            make.top.equalTo(titleLabel.snp.bottom).offset(3)
        }
        containerForWeight.snp.makeConstraints { make in
            make.left.right.equalTo(container)
            make.top.equalTo(subtitleLabel).inset(20)
            make.height.equalTo(20)
        }
        weightLabel.snp.makeConstraints { make in
            make.left.equalTo(titleLabel.snp.left)
            make.top.equalTo(containerForWeight.snp.top).inset(10)
        }
        weightValueLabel.snp.makeConstraints { make in
            make.right.equalTo(containerForWeight.snp.right).inset(30)
            make.top.equalTo(containerForWeight.snp.top).inset(10)
        }
        
        containerForCalories.snp.makeConstraints { make in
            make.left.right.equalTo(container)
            make.top.equalTo(containerForWeight.snp.bottom).offset(5)
            make.height.equalTo(20)
        }
        caloriesLabel.snp.makeConstraints { make in
            make.left.equalTo(titleLabel.snp.left)
            make.top.equalTo(containerForCalories.snp.top).inset(10)
        }
        caloriesValueLabel.snp.makeConstraints { make in
            make.right.equalTo(containerForCalories.snp.right).inset(30)
            make.top.equalTo(containerForCalories.snp.top).inset(10)
        }
        
        containerForProtein.snp.makeConstraints { make in
            make.left.right.equalTo(container)
            make.top.equalTo(containerForCalories.snp.bottom).offset(5)
            make.height.equalTo(20)
        }
        proteinLabel.snp.makeConstraints { make in
            make.left.equalTo(titleLabel.snp.left)
            make.top.equalTo(containerForProtein.snp.top).inset(10)
        }
        proteinValueLabel.snp.makeConstraints { make in
            make.right.equalTo(containerForProtein.snp.right).inset(30)
            make.top.equalTo(containerForProtein.snp.top).inset(10)
        }
        
        containerForFats.snp.makeConstraints { make in
            make.left.right.equalTo(container)
            make.top.equalTo(containerForProtein.snp.bottom).offset(5)
            make.height.equalTo(20)
        }
        fatsLabel.snp.makeConstraints { make in
            make.left.equalTo(titleLabel.snp.left)
            make.top.equalTo(containerForFats.snp.top).inset(10)
        }
        fatsValueLabel.snp.makeConstraints { make in
            make.right.equalTo(containerForFats.snp.right).inset(30)
            make.top.equalTo(containerForFats.snp.top).inset(10)
        }
        
        containerForCarbohydrates.snp.makeConstraints { make in
            make.left.right.equalTo(container)
            make.top.equalTo(containerForFats.snp.bottom).offset(5)
            make.height.equalTo(20)
        }
        carbohydratesLabel.snp.makeConstraints { make in
            make.left.equalTo(titleLabel.snp.left)
            make.top.equalTo(containerForCarbohydrates.snp.top).inset(10)
        }
        carbohydratesValueLabel.snp.makeConstraints { make in
            make.right.equalTo(containerForCarbohydrates.snp.right).inset(30)
            make.top.equalTo(containerForCarbohydrates.snp.top).inset(10)
        }
        containerForMayContainAndAllergies.snp.makeConstraints { make in
            make.left.equalTo(container)
            make.right.equalTo(container.snp.right).inset(30)
            make.top.equalTo(containerForCarbohydrates.snp.bottom).offset(10)
            make.bottom.equalTo(view.snp.bottom)
        }
        
        mayContainLabel.snp.makeConstraints { make in
            make.top.equalTo(containerForMayContainAndAllergies.snp.top).inset(5)
            make.left.equalTo(titleLabel.snp.left)
            make.right.equalTo(containerForMayContainAndAllergies.snp.right).inset(15)
            make.bottom.equalTo(allergiesLabel.snp.top).offset(-5)
        }
        
        allergiesLabel.snp.makeConstraints { make in
            make.top.equalTo(mayContainLabel.snp.bottom).offset(5)
            make.left.equalTo(titleLabel.snp.left)
            make.right.equalTo(containerForMayContainAndAllergies.snp.right).inset(15)
            make.bottom.equalTo(containerForMayContainAndAllergies.snp.bottom).inset(5)
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
