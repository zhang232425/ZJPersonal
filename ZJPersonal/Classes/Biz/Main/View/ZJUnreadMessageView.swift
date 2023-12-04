//
//  ZJUnreadMessageView.swift
//  ZJPersonal
//
//  Created by Jercan on 2023/12/1.
//

import UIKit

class ZJUnreadMessageView: BaseView {
    
    var count: Int = 0 {
        didSet {
            bageView.isHidden = (count <= 0)
        }
    }
    
    private lazy var imageView = UIImageView().then {
        $0.image = .named("main_msg_icon")
    }
    
    private lazy var bageView = UIView().then {
        $0.backgroundColor = UIColor(hexString: "FF4D4F")
        $0.isHidden = true
        $0.layer.cornerRadius = 3.auto
        $0.layer.masksToBounds = true
    }

    override func setupViews() {
        
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(readClick)))
        
        imageView.add(to: self).snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.size.equalTo(28.auto)
        }
        
        bageView.add(to: self).snp.makeConstraints {
            $0.size.equalTo(6.auto)
            $0.top.equalTo(imageView).offset(2.auto)
            $0.right.equalTo(imageView).offset(-4.auto)
        }
        
    }

}

private extension ZJUnreadMessageView {
    
    @objc func readClick() {
        
        print("响应者链 ===== \(#function)")
        
    }
    
}
