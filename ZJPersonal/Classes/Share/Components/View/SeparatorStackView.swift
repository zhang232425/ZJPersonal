//
//  SeparatorStackView.swift
//  ZJPersonal
//
//  Created by Jercan on 2023/12/1.
//

import UIKit

class SeparatorStackView: UIStackView {

    /// 分割线颜色
    var separatorColor: UIColor? = nil
    
    /// 分割线粗细
    var separatorWidth = CGFloat(1)
    
    /// 分割线两端inset
    var separatorInsets = CGFloat(0)
    
    private var separators = [CALayer]()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        switch axis {
        case .horizontal:
            resetXSeparators()
        case .vertical:
            resetYSeparators()
        @unknown default: break
        }
    }
    
    private func resetXSeparators() {
        
        guard arrangedSubviews.count > 1 else { return }
        
        separators.forEach { $0.removeFromSuperlayer() }
        separators.removeAll()
        
        for (i, v) in arrangedSubviews.enumerated() where i < arrangedSubviews.count-1 {
            let layer = CALayer()
            layer.backgroundColor = separatorColor?.cgColor
            layer.frame = .init(x: v.frame.maxX + (spacing / 2),
                                y: separatorInsets,
                                width: separatorWidth,
                                height: bounds.height - (2 * separatorInsets))
            separators.append(layer)
            self.layer.addSublayer(layer)
        }
        
    }
    
    private func resetYSeparators() {
        
        guard arrangedSubviews.count > 1 else { return }
        
        separators.forEach { $0.removeFromSuperlayer() }
        separators.removeAll()
        
        for (i, v) in arrangedSubviews.enumerated() where i < arrangedSubviews.count-1 {
            let layer = CALayer()
            layer.backgroundColor = separatorColor?.cgColor
            layer.frame = .init(x: separatorInsets,
                                y: v.frame.maxY + (spacing / 2),
                                width: bounds.width - (2 * separatorInsets),
                                height: separatorWidth)
            separators.append(layer)
            self.layer.addSublayer(layer)
        }
        
    }

}
