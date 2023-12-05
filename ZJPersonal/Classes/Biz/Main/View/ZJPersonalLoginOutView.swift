//
//  ZJPersonalLoginOutView.swift
//  ZJPersonal
//
//  Created by Jercan on 2023/12/1.
//

import UIKit

class ZJPersonalLoginOutView: BaseView {
    
    private lazy var mainLabel = UILabel().then {
        $0.textColor = UIColor(hexString: "333333")
        $0.font = .bold20
        $0.numberOfLines = 0
        $0.text = Locale.main_welcome_title.localized
    }
    
    private lazy var descLabel = UILabel().then {
        $0.textColor = UIColor(hexString: "999999")
        $0.font = .regular12
        $0.numberOfLines = 0
        $0.text = Locale.main_welcome_desc.localized
    }
    
    private lazy var imageView = UIImageView().then {
        $0.image = .named("main_unlogin_image")
    }
    
    private lazy var button = UIButton(type: .custom).then {
        $0.backgroundColor = UIColor(hexString: "FF7D0F")
        $0.titleLabel?.font = UIFont.medium14
        $0.contentEdgeInsets = .init(top: 0, left: 18, bottom: 0, right: 18)
        $0.setTitleColor(.white, for: .normal)
        $0.setTitleColor(UIColor.white.withAlphaComponent(0.5), for: .highlighted)
        $0.addTarget(self, action: #selector(buttonClick), for: .touchUpInside)
        $0.setTitle(Locale.main_unlogin_btn_title.localized, for: .normal)
        $0.layer.cornerRadius = 15.auto
        $0.layer.masksToBounds = true
    }

    override func setupViews() {
        
        backgroundColor = .white
        
        imageView.add(to: self).snp.makeConstraints {
            $0.right.equalToSuperview().inset(10.auto)
            $0.width.height.equalTo(self.snp.width).dividedBy(3)
            $0.centerY.equalToSuperview().offset(5.auto)
        }
        
        mainLabel.add(to: self).snp.makeConstraints {
            $0.top.equalToSuperview().inset(15.auto)
            $0.left.equalToSuperview().inset(15.auto)
            $0.right.equalTo(imageView.snp.left).offset(-4.auto)
        }
        
        descLabel.add(to: self).snp.makeConstraints {
            $0.top.equalTo(mainLabel.snp.bottom).offset(8.auto)
            $0.left.equalTo(15.auto)
            $0.right.equalTo(imageView.snp.left).offset(-4.auto)
        }
        
        button.add(to: self).snp.makeConstraints {
            $0.top.equalTo(descLabel.snp.bottom).offset(14.auto)
            $0.left.equalTo(15.auto)
            $0.height.equalTo(30.auto)
            $0.right.lessThanOrEqualTo(imageView.snp.left)
            $0.bottom.equalToSuperview().inset(35.auto)
        }
        
    }
    
}

private extension ZJPersonalLoginOutView {
    
    @objc func buttonClick() {
        ZJPersonalClickEvent.loginOrRegister.post(by: self)
    }
    
}
