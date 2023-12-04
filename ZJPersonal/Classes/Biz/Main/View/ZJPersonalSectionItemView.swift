//
//  ZJPersonalSectionItemView.swift
//  ZJPersonal
//
//  Created by Jercan on 2023/12/4.
//

import UIKit

class ZJPersonalSectionItemView: BaseView {

    private let section: ZJPersonalSection

    private(set) lazy var iconImageView = UIImageView()
    
    private(set) lazy var label = UILabel().then {
        $0.textColor = UIColor(hexString: "666666")
        $0.font = .regular14
        $0.textAlignment = .left
        $0.numberOfLines = 1
    }
    
    private lazy var badgeView = UIView().then {
        $0.backgroundColor = UIColor(hexString: "FF4D4F")
        $0.isHidden = true
    }
    
    private lazy var arrowImageView = UIImageView().then {
        $0.image = .named("main_list_arrowicon")
    }
    
    init(section: ZJPersonalSection) {
        self.section = section
        super.init(frame: .zero)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupViews() {
        
        self.backgroundColor = .white
        
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(click)))
        
        iconImageView.add(to: self).snp.makeConstraints {
            $0.left.equalToSuperview().inset(16.auto)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(25.auto)
        }
        
        label.add(to: self).snp.makeConstraints {
            $0.left.equalTo(iconImageView.snp.right).offset(8.auto)
            $0.centerY.equalToSuperview()
            $0.right.equalToSuperview().inset(40.auto)
        }
        
        arrowImageView.add(to: self).snp.makeConstraints {
            $0.right.equalToSuperview().inset(16.auto)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(16.auto)
        }
        
        badgeView.add(to: self).snp.makeConstraints {
            $0.left.equalToSuperview().inset(36.auto)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(6.auto)
        }
        
        badgeView.layer.cornerRadius = 3.auto
        badgeView.layer.masksToBounds = true
        
        let line = UIView().then {
            $0.backgroundColor = UIColor(hexString: "F0F0F0")
        }
        
        line.add(to: self).snp.makeConstraints {
            $0.left.equalToSuperview().inset(28.auto)
            $0.right.equalToSuperview().inset(20.auto)
            $0.height.equalTo(1)
            $0.bottom.equalToSuperview()
        }
        
        
    }

}

private extension ZJPersonalSectionItemView {
    
    @objc func click() {
        
        
        
    }
    
}
