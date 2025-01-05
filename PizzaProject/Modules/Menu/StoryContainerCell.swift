//
//  StoryContainerCell.swift
//  PizzaProject
//
//  Created by Artem Khlevchuk on 14.10.2024.
//

import UIKit
import SnapKit

final class StoryContainerCell: UITableViewCell {
    
    private var stories = [String]()
    
    private lazy var containerView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSize(width: 100 , height: 140)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        collectionView.layer.cornerRadius = 40
        collectionView.layer.masksToBounds = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .white
        collectionView.registerCell(StoryCollectionCell.self)
        
        return collectionView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupConstaints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: - Layout

extension StoryContainerCell {
    
    private func setupViews() {
        contentView.backgroundColor = Colors.backgroundColor
        contentView.addSubview(containerView)
    }
    
    private func setupConstaints() {
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(130)
        }
    }
}

//MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension StoryContainerCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return stories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(indexPath) as StoryCollectionCell
        let story = stories[indexPath.row]
        cell.update(story)
        return cell
    }
}

//MARK: - Public

extension StoryContainerCell {
    func bind(stories: [String]) {
        self.stories = stories
    }
}
