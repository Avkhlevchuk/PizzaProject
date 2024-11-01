//
//  CustomeSegmentControl.swift
//  PizzaProject
//
//  Created by Artem Khlevchuk on 16.10.2024.
//

import UIKit

class CustomizableSegmentControl: UISegmentedControl {
    
    lazy var radius = self.bounds.height / 2
    
    private var segmentInset: CGFloat = 5 {
        didSet {
            if segmentInset == 0 {
                segmentInset = 5
            }
        }
    }
    
    override init(items: [Any]?) {
        super.init(items: items)
        selectedSegmentIndex = 1
        
        //MARK: - Delete seperate line
        setDividerImage(UIImage(), forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.backgroundColor = UIColor(red: 254.0/255.0, green: 230.0/255.0, blue: 208.0/255.0, alpha: 1)
        self.layer.cornerRadius = self.radius
        self.layer.masksToBounds = true
        self.setTitleTextAttributes([.foregroundColor: UIColor.black], for: .normal)
        self.setTitleTextAttributes([.foregroundColor: UIColor.black], for: .selected)
        
        
        //MARK: - Custom selectedImageView
        let selectedImageViewIndex = numberOfSegments
        
        if let selectedImageView = subviews[selectedImageViewIndex] as? UIImageView {
            selectedImageView.backgroundColor = .white
            selectedImageView.image = nil
            
            //MARK: - Configure selectedImageView Inset with SegmentControl
            selectedImageView.bounds = selectedImageView.bounds.insetBy(dx: segmentInset, dy: segmentInset)
            
            //MARK: - Configure selectedImageView cornerradius
            selectedImageView.layer.masksToBounds = true
            selectedImageView.layer.cornerRadius = self.radius - 2
            
            //MARK: - Fix bug animation
            selectedImageView.layer.removeAnimation(forKey: "SelectionBounds")
            
        }
    }
    
}
