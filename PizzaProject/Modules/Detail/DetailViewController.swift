//
//  DetailViewController.swift
//  PizzaProject
//
//  Created by Artem Khlevchuk on 16.10.2024.
//

import UIKit
import SnapKit

class DetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var titleDetailView = TitleDetailView()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        
        tableView.contentInset = .init(top: 30, left: 0, bottom: -35, right: 0)
        tableView.backgroundColor = Colors.backGroundBeige
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        
        tableView.register(DetailProductViewCell.self, forCellReuseIdentifier: DetailProductViewCell.reuseId)
        tableView.register(IngredientDetailTableViewCell.self, forCellReuseIdentifier: IngredientDetailTableViewCell.reuseId)
        tableView.register(ToppingsContainerCell.self, forCellReuseIdentifier: ToppingsContainerCell.reuseId)
//        tableView.bounces = false
        
        let footerView = UIView.init(frame: CGRect(x: 0, y: 0, width: 0, height: 100))
        footerView.backgroundColor = .white
        tableView.tableFooterView = footerView
        
        
        return tableView
    }()
    
    let typeBasePizzaSegmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl()
        return segmentedControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
        setupBinding()

    }
    
    func setupViews() {
        [tableView, titleDetailView].forEach {
            view.addSubview($0)
        }
    }
    
    func setupConstraints() {
        
        titleDetailView.snp.makeConstraints { make in
            make.left.right.equalTo(view)
            make.top.equalTo(view)
            make.height.equalTo(100)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalToSuperview()
            
        }
    }
    
    func setupBinding() {
                
        titleDetailView.onCloseButtonTaped = { [weak self] in
            self?.dismiss(animated: true, completion: nil)
        }
    }
//MARK: - UITableViewDataSource, UITableViewDelegate
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        case 2:
            return 1
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailProductViewCell.reuseId, for: indexPath) as? DetailProductViewCell else { return UITableViewCell() }
            cell.selectionStyle = .none
            return cell
        case 1:
            //
            guard let cell = tableView.dequeueReusableCell(withIdentifier: IngredientDetailTableViewCell.reuseId, for: indexPath) as? IngredientDetailTableViewCell else { return UITableViewCell() }
            cell.selectionStyle = .none
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ToppingsContainerCell.reuseId, for: indexPath) as? ToppingsContainerCell else { return UITableViewCell() }
            cell.selectionStyle = .none
            return cell
        default:
            return UITableViewCell()
        }
        
    }
}

//MARK: - Events Handler

extension DetailViewController {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}
