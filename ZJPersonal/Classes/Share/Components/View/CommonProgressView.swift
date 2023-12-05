//
//  CommonProgressView.swift
//  ZJPersonal
//
//  Created by Jercan on 2023/12/4.
//

import UIKit

class CommonProgressView: BaseView {
    
    /// 当前进度
    var progress = CGFloat(0) {
        didSet {
            setNeedsLayout()
            layoutIfNeeded()
        }
    }
    
    /// 背景颜色
    var normalColor = UIColor(hexString: "#F2F2F2") {
        didSet { backgroundColor = normalColor }
    }
    
    /// 进度颜色
    var progressColor = UIColor(hexString: "#FF7D0F") {
        didSet { progressView.backgroundColor = progressColor }
    }
    
    private lazy var progressView = UIView().then {
        $0.backgroundColor = progressColor
    }
    
    override func setupViews() {
        backgroundColor = normalColor
        progressView.add(to: self)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = bounds.height / 2
        progressView.layer.cornerRadius = progressView.bounds.height / 2
        progressView.layer.masksToBounds = true
        
        let percent = max(0, min(1, progress))
        let width = percent * bounds.width
        progressView.frame = .init(x: 0, y: 0, width: width, height: bounds.height)
    }
    
}
