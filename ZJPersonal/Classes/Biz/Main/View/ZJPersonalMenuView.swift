//
//  ZJPersonalMenuView.swift
//  ZJPersonal
//
//  Created by Jercan on 2023/12/1.
//

import UIKit

class ZJPersonalMenuView: BaseView {

    private lazy var stackView = SeparatorStackView().then {
        $0.axis = .horizontal
        $0.spacing = 0
        $0.distribution = .fill
        $0.alignment = .fill
        $0.separatorInsets = 15.auto
        $0.separatorColor = UIColor(hexString: "E5E5E5")
        $0.separatorWidth = 0.5
    }
    
    override func setupViews() {
        
        self.backgroundColor = .white
        
        let contentView = UIView().then {
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor(hexString: "#F0F0F0").cgColor
            $0.layer.cornerRadius = 8
            $0.layer.masksToBounds = true
        }
        
        contentView.add(to: self).snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(15.auto)
            $0.top.bottom.equalToSuperview().inset(6.auto)
        }
        
        stackView.add(to: contentView).snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        ZJPersonalMenuItemView.MenuItem.allCases.forEach {
            let view = ZJPersonalMenuItemView(item: $0)
            view.titleLabel.text = $0.title
            view.imageView.image = .named($0.imageName)
            stackView.addArrangedSubview(view)
        }
        
    }

}

extension ZJPersonalMenuView {
    
    func updateUnusedCoupon(count: Int) {
        
        let itemView = stackView.arrangedSubviews.filter{ ($0 as? ZJPersonalMenuItemView)?.item == .coupon }.first
        let label = (itemView as! ZJPersonalMenuItemView).valueLabel
        
        var text = "\(count) " + Locale.main_coupon_unused.localized
        if count > 1 {
            text.append("s")
        }
        label.text = (count <= 0) ? nil : text
    }
    
    func updateInviteCouponNotice(_ text: String) {
            
        let itemView = stackView.arrangedSubviews.filter { ($0 as? ZJPersonalMenuItemView)?.item == .invite }.first
        let label = (itemView as! ZJPersonalMenuItemView).valueLabel
        label.text = text
        
    }
    
}

fileprivate class ZJPersonalMenuItemView: BaseView {
    
    enum MenuItem: CaseIterable {
        
        case invite
        case coupon
        
        var title: String {
            switch self {
            case .invite:
                return Locale.main_invite_title.localized
            case .coupon:
                return Locale.main_coupon_title.localized
            }
        }
        
        var imageName: String {
            switch self {
            case .invite:
                return "main_list_menu_invite"
            case .coupon:
                return "main_list_menu_coupon"
            }
        }
        
    }
    
    let item: MenuItem

    private(set) lazy var titleLabel = UILabel().then {
        $0.textColor = UIColor(hexString: "666666")
        $0.font = .medium14
        $0.numberOfLines = 0
    }
    
    private(set) lazy var valueLabel = UILabel().then {
        $0.textColor = UIColor(hexString: "FF7D0F")
        $0.font = .medium12
        $0.numberOfLines = 0
    }
    
    private(set) lazy var imageView = UIImageView()
    
    init(item: MenuItem) {
        self.item = item
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupViews() {
        
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(click)))
        
        imageView.add(to: self).snp.makeConstraints {
            $0.right.equalToSuperview().inset(10.auto)
            $0.size.equalTo(56.auto)
            $0.centerY.equalToSuperview()
        }
        
        titleLabel.add(to: self).snp.makeConstraints {
            $0.top.equalToSuperview().inset(16.auto)
            $0.left.equalToSuperview().inset(10.auto)
            $0.right.equalTo(imageView.snp.left)
            $0.bottom.equalTo(self.snp.centerY).offset(-2.auto)
        }
        
        valueLabel.add(to: self).snp.makeConstraints {
            $0.left.equalToSuperview().inset(10.auto)
            $0.right.equalTo(imageView.snp.left)
            $0.top.equalTo(self.snp.centerY).offset(2.auto)
            $0.bottom.equalToSuperview().inset(16.auto)
        }
        
    }
    
    @objc func click() {
        
        switch item {
        case .invite:
            ZJPersonalClickEvent.inviteFriends.post(by: self)
        case .coupon:
            ZJPersonalClickEvent.couponList.post(by: self)
        }
        
    }
    
}
