//
//  BadgeLabel.swift
//  ZJPersonal
//
//  Created by Jercan on 2023/12/12.
//

import UIKit

class BadgeLabel: UILabel {

    struct CornerRii {
        let tl: CGFloat
        let tr: CGFloat
        let bl: CGFloat
        let br: CGFloat
    }
    
    let corners: CornerRii
    
    /// 文字内边距
    var textInsets: UIEdgeInsets = .zero
    
    init(corners: CornerRii) {
        self.corners = corners
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        
        guard text != nil else {
            return super.textRect(forBounds: bounds, limitedToNumberOfLines: numberOfLines)
        }
        
        let insetRect = UIEdgeInsetsInsetRect(bounds, textInsets)
        let textRect = super.textRect(forBounds: insetRect, limitedToNumberOfLines: numberOfLines)
        let invertedInsets = UIEdgeInsets(top: -textInsets.top,
                                          left: -textInsets.left,
                                          bottom: -textInsets.bottom,
                                          right: -textInsets.right)
        return UIEdgeInsetsInsetRect(textRect, invertedInsets)
    }
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: UIEdgeInsetsInsetRect(rect, textInsets))
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if bounds.height > 0 {
            
            let path = UIBezierPath(roundedRect: self.bounds,
                                    cornerRadii: (topLeft: corners.tl,
                                                  topRight: corners.tr,
                                                  bottomLeft: corners.bl,
                                                  bottomRight: corners.br))
            let shapeLayer = CAShapeLayer()
            shapeLayer.frame = bounds
            shapeLayer.path = path.cgPath
            layer.mask = shapeLayer
        }
    }

}

private extension UIBezierPath {
    
    /// convenience
    convenience init(roundedRect bounds: CGRect,
                     cornerRadii radii: (topLeft: CGFloat, topRight: CGFloat, bottomLeft: CGFloat, bottomRight: CGFloat)) {
        self.init()
        
        func point(x: CGFloat, y: CGFloat) -> CGPoint {
            CGPoint(x: bounds.origin.x + x, y: bounds.origin.y + y)
        }
        
        move(to: point(x: radii.topLeft, y: 0))
        addLine(to: point(x: bounds.width - radii.topRight, y: 0))
        addArc(withCenter: point(x: bounds.width - radii.topRight, y: radii.topRight),
               radius: radii.topRight, startAngle: .pi * 1.5, endAngle: 0, clockwise: true)
        addLine(to: point(x: bounds.width, y: bounds.height - radii.bottomRight))
        addArc(withCenter: point(x: bounds.width - radii.bottomRight, y: bounds.height - radii.bottomRight),
               radius: radii.bottomRight, startAngle: 0, endAngle: .pi * 0.5, clockwise: true)
        addLine(to: point(x: radii.bottomLeft, y: bounds.height))
        addArc(withCenter: point(x: radii.bottomLeft, y: bounds.height - radii.bottomLeft),
               radius: radii.bottomLeft, startAngle: .pi * 0.5, endAngle: .pi, clockwise: true)
        addLine(to: point(x: 0, y: radii.topLeft))
        addArc(withCenter: point(x: radii.topLeft, y: radii.topLeft),
               radius: radii.topLeft, startAngle: .pi, endAngle: .pi * 1.5, clockwise: true)
        close()
    }
}
