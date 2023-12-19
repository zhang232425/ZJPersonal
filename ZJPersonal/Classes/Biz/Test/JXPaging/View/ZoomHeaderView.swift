//
//  ZoomHeaderView.swift
//  ZJPersonal
//
//  Created by Jercan on 2023/12/15.
//

import UIKit

class ZoomHeaderView: BaseView {
    
    var imageViewFrame: CGRect = CGRect.zero
    
    private lazy var imageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.image = .named("lufei")
    }
    
    private lazy var nameLabel = UILabel().then {
        $0.font = .bold20
        $0.textColor = .red
        $0.text = "Monkey·D·路飞"
    }
    
    private lazy var followBtn = UIButton(type: .system).then {
        $0.setTitle("关注", for: .normal)
    }
    
    override func setupViews() {
        
        imageView.add(to: self).snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        nameLabel.add(to: self).snp.makeConstraints {
            $0.left.equalToSuperview().inset(15.auto)
            $0.bottom.equalToSuperview().inset(10.auto)
        }
        
        followBtn.add(to: self).snp.makeConstraints {
            $0.left.equalTo(nameLabel.snp.right).offset(30.auto)
            $0.centerY.equalTo(nameLabel)
        }
        
    }
    
}

extension ZoomHeaderView {
    
    func scrollViewDidScroll(contentOffsetY: CGFloat) {
        
        var frame = imageViewFrame
        frame.size.height -= contentOffsetY
        frame.origin.y = contentOffsetY
        imageView.frame = frame
        
    }
    
    
}
