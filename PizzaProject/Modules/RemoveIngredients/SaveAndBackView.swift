//
//  SaveAndBackView.swift
//  PizzaProject
//
//  Created by Artem Khlevchuk on 19.11.2024.
//

import UIKit
import SnapKit

class SaveAndBackView: UIView {
    
    var onCloseButtonTapped: (()->())?
    var onSaveButtonTapped: (()->())?
    var onResetButtonTapped: (()->())?
    
    private lazy var closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Close", for: .normal)
        button.addTarget(nil, action: #selector(closeButtonTapped), for: .touchUpInside)
        button.tintColor = Colors.orange
        return button
    }()
    
    @objc func closeButtonTapped() {
        onCloseButtonTapped?()
    }
    
   private lazy var saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Save", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(nil, action: #selector(saveButtonTapped), for: .touchUpInside)
        button.backgroundColor = Colors.orange
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        
        return button
    }()
    
    @objc func saveButtonTapped() {
        onSaveButtonTapped?()
    }
    
    private lazy var resetButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Reset", for: .normal)
        button.setTitleColor(Colors.darkOrange, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.addTarget(nil, action: #selector(resetButtonTapped), for: .touchUpInside)
        return button
    }()
    
    @objc func resetButtonTapped() {
        onResetButtonTapped?()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        [closeButton, saveButton, resetButton].forEach {
            self.addSubview($0)
        }
        
        saveButton.isHidden = true
        resetButton.isHidden = true
    }
    
    func setupConstraints() {
        closeButton.snp.makeConstraints { make in
            make.left.equalTo(self.snp.left).inset(15)
            make.top.equalTo(self.snp.top).inset(15)
        }
        saveButton.snp.makeConstraints { make in
            make.left.equalTo(self.snp.left).inset(20)
            make.top.equalTo(self).inset(20)
            make.bottom.equalTo(self.snp.bottom)
            make.right.equalTo(self.snp.centerX).inset(10)
        }
        resetButton.snp.makeConstraints { make in
            make.right.equalTo(self.snp.right).inset(20)
            make.top.equalTo(self).inset(20)
            make.bottom.equalTo(self.snp.bottom)
            make.left.equalTo(self.snp.centerX).offset(10)
        }
    }
}

//MARK: - Event handler

extension SaveAndBackView {
    func showCloseButton() {
        UIView.animate(withDuration: 0.3, animations: { [weak self] in
            guard let self = self else { return }
            closeButton.isHidden = false
            saveButton.isHidden = true
            resetButton.isHidden = true
        })
    }
    
    func showSaveAndResetButton() {
        UIView.animate(withDuration: 0.3, animations: { [weak self] in
            guard let self = self else { return }
            closeButton.isHidden = true
            saveButton.isHidden = false
            resetButton.isHidden = false
        })
    }
}
