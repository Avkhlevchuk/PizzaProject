//
//  StoryCollectionView.swift
//  PizzaProject
//
//  Created by Artem Khlevchuk on 14.10.2024.
//

import UIKit
import SnapKit

final class StoryCollectionCell: UICollectionViewCell {
    
    static let reuseId = "StoryCollectionCell"
        
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "stories")
        imageView.contentMode = .scaleAspectFill
        let width = UIScreen.main.bounds.width
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 15
        imageView.layer.masksToBounds = true
        
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        contentView.addSubview(imageView)
    }
    
    func setupConstraints() {
        
        imageView.snp.makeConstraints { make in
            make.left.equalTo(contentView).inset(10)
            make.right.equalTo(contentView)
            make.top.bottom.equalTo(contentView).inset(10)
        }
    }
}

//MARK: - Update view
extension StoryCollectionCell {
    func update(_ story: String) {
        imageView.image = UIImage(named: story)
    }
}
