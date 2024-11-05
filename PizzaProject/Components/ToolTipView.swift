//
//  ToolTipView.swift
//  PizzaProject
//
//  Created by Artem Khlevchuk on 01.11.2024.
//

import UIKit

enum ToolTipPosition: Int {
    case left
    case right
    case middle
}

class ToolTipView: UIView {
    private let toolTipWidth: CGFloat = 20.0
    private let toolTipHeight: CGFloat = 20.0
    private let tipOffset: CGFloat = 20.0
    private var tipPosition: ToolTipPosition = .middle
    private var label: UILabel = UILabel()

    private var roundRect: CGRect!
    private var titleLabel: UILabel = {
        let title = UILabel()
        title.font = UIFont.boldSystemFont(ofSize: 16)
        title.textColor = .white
        return title
    }()

    init(frame: CGRect, text: String, tipPos: ToolTipPosition, titleLabel: UILabel) {
        super.init(frame: frame)
        self.titleLabel = titleLabel
        self.tipPosition = tipPos
        setupLabel(with: text)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    private func setupLabel(with text: String) {
        label.text = text
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .left
        addSubview(label)
        
        // Установка ограничений для лейбла
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -toolTipHeight - 8)
        ])
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        drawToolTip(rect)
        self.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.left.top.equalTo(self).inset(15)
        }
    }
    

    
    private func createTipPath() -> UIBezierPath {
        // Определяем положение треугольника для позиции .right
        let tooltipRect = CGRect(x: roundRect.maxX, // Ставим треугольник справа
                                 y: roundRect.midY - toolTipHeight / 2, // Центрируем по вертикали
                                 width: toolTipWidth,
                                 height: toolTipHeight)
        
        let trianglePath = UIBezierPath()
        trianglePath.move(to: CGPoint(x: tooltipRect.minX, y: tooltipRect.minY)) // Верхняя левая точка
        trianglePath.addLine(to: CGPoint(x: tooltipRect.maxX, y: tooltipRect.midY)) // Правая центральная точка
        trianglePath.addLine(to: CGPoint(x: tooltipRect.minX, y: tooltipRect.maxY)) // Нижняя левая точка
        trianglePath.close() // Замыкаем путь

        return trianglePath
    }



    
    private func drawToolTip(_ rect: CGRect) {
        roundRect = CGRect(x: rect.minX, y: rect.minY, width: rect.width, height: rect.height - toolTipHeight)
        let roundRectPath = UIBezierPath(roundedRect: roundRect, cornerRadius: 5.0)
        let trianglePath = createTipPath()
        roundRectPath.append(trianglePath)
        
        let shapeLayer = createShapeLayer(with: roundRectPath.cgPath)
        layer.insertSublayer(shapeLayer, at: 0)
    }

    private func createShapeLayer(with path: CGPath) -> CAShapeLayer {
        let shape = CAShapeLayer()
        shape.path = path
        shape.fillColor = UIColor.darkGray.cgColor
        shape.shadowColor = UIColor.black.withAlphaComponent(0.6).cgColor
        shape.shadowOffset = CGSize(width: 0, height: 2)
        shape.shadowRadius = 5.0
        shape.shadowOpacity = 0.8
        return shape
    }
    
    private func getXPosition() -> CGFloat {
        switch tipPosition {
        case .left:
            return roundRect.minX + tipOffset
        case .right:
            return roundRect.maxX - toolTipWidth - tipOffset
        case .middle:
            return roundRect.midX - toolTipWidth / 2
        }
    }
}
