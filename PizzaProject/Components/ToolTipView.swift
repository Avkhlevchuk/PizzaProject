//
//  ToolTipView.swift
//  PizzaProject
//
//  Created by Artem Khlevchuk on 01.11.2024.
//

import UIKit

class ToolTipView: UIView {

    private let messageLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    init(message: String) {
        super.init(frame: .zero)
        setupView()
        messageLabel.text = message
        setNeedsDisplay() // Обновляем отображение для вызова метода draw(_:)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = .darkGray
        layer.cornerRadius = 10
        layer.masksToBounds = false // Отключаем, чтобы треугольник не обрезался

        addSubview(messageLabel)
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            messageLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20) // Оставляем место для треугольника
        ])
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        // Отступ для треугольника
        let triangleHeight: CGFloat = 10
        let triangleWidth: CGFloat = 20

        // Создаем путь для треугольника
        let trianglePath = UIBezierPath()
        
        // Определяем положение треугольника относительно нижней границы view
        trianglePath.move(to: CGPoint(x: rect.width / 2 - triangleWidth / 2, y: rect.height - triangleHeight))
        trianglePath.addLine(to: CGPoint(x: rect.width / 2 + triangleWidth / 2, y: rect.height - triangleHeight))
        trianglePath.addLine(to: CGPoint(x: rect.width / 2, y: rect.height))
        trianglePath.close()

        // Задаем цвет заливки
        UIColor.darkGray.setFill()
        trianglePath.fill()
    }

}
