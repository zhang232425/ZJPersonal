//
//  ZJPersonalLoginInView.swift
//  ZJPersonal
//
//  Created by Jercan on 2023/12/1.
//

import UIKit
import ZJCommonView
import ZJLoginManager
import ZJLocalizable

class ZJPersonalLoginOnView: BaseView {
    
    private lazy var topView = TopView().then {
        $0.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(topClick)))
    }
    
    private lazy var imageView = UIImageView()
    
    private lazy var bottomView = BottomView().then {
        $0.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(bottomClick)))
    }

    override func setupViews() {
        
        topView.add(to: self).snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
        }
        
        bottomView.add(to: self).snp.makeConstraints {
            $0.top.equalTo(topView.snp.bottom)
            $0.bottom.left.right.equalToSuperview()
        }
        
    }
    
    @objc func topClick() {
        
        
    }
    
    @objc func bottomClick() {
        
        
    }
    
    func updateProfile(_ profile: ZJUserProfile) {
        
        topView.updateProfile(profile: profile)
        bottomView.updateProfile(profile: profile)
        
    }

}

fileprivate class TopView: BaseView {
    
    private lazy var avatarImageView = UIImageView().then {
        $0.layer.cornerRadius = 28.auto
        $0.layer.masksToBounds = true
    }
    
    private lazy var nameLabel = UILabel().then {
        $0.textColor = UIColor(hexString: "333333")
        $0.font = .medium16
        $0.numberOfLines = 1
    }
    
    private lazy var levelImageView = UIImageView()
        
    private lazy var certificateBtn = UIButton(type: .custom).then {
        $0.isHidden = true
        $0.addTarget(self, action: #selector(certificateBtnClick), for: .touchUpInside)
    }
        
    private lazy var arrawImageView = UIImageView().then {
        $0.image = .named("main_info_arrowicon")
    }
    
    override func setupViews() {
        
        avatarImageView.add(to: self).snp.makeConstraints {
            $0.top.equalToSuperview().inset(12.auto)
            $0.left.equalToSuperview().inset(16.auto)
            $0.size.equalTo(56.auto)
            $0.bottom.equalToSuperview().inset(16.auto)
        }
        
        
        nameLabel.add(to: self).snp.makeConstraints {
            $0.left.equalTo(avatarImageView.snp.right).offset(16.auto)
            $0.right.equalToSuperview().inset(50.auto)
            $0.bottom.equalTo(avatarImageView.snp.centerY).offset(-5.auto)
        }
        
        levelImageView.add(to: self).snp.makeConstraints {
            $0.left.equalTo(avatarImageView.snp.right).offset(16.auto)
            $0.top.equalTo(avatarImageView.snp.centerY).offset(4.auto)
            $0.width.equalTo(31.auto)
            $0.height.equalTo(18.auto)
        }
        
        certificateBtn.add(to: self).snp.makeConstraints {
            $0.left.equalTo(levelImageView.snp.right).offset(8.auto)
            $0.centerY.equalTo(levelImageView.snp.centerY)
            $0.width.equalTo(77.auto)
            $0.height.equalTo(21.auto)
        }
        
        arrawImageView.add(to: self).snp.makeConstraints {
            $0.right.equalToSuperview().inset(16.auto)
            $0.centerY.equalTo(avatarImageView)
            $0.size.equalTo(25.auto)
        }
        
    }
    
    @objc func certificateBtnClick() {
        
    }
    
    func updateProfile(profile: ZJUserProfile) {
        
        avatarImageView.setImage(with: profile.avatarUrl, placeholder: .named("main_avatar_placeholder"))
        nameLabel.text = profile.userName.isEmpty ? profile.phoneEncrypt : profile.userName
        
        let level = UserMembershipLevel(string: profile.membershipLevel) ?? .normal
        levelImageView.image = .named(level.topviewImageName)
        
    }
    
}

fileprivate class BottomView: BaseView {
    
    private lazy var gadientView = _GradientView()
    
    private lazy var imageView = UIImageView()
    
    private lazy var infoView = ZJMembershipInfoView()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setCornerRadius(8, for: [.topLeft, .topRight], of: imageView)
    }
    
    override func setupViews() {
        
        gadientView.add(to: self).snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.height.equalTo(11.auto)
            $0.bottom.equalToSuperview()
        }
        
        imageView.add(to: self).snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.left.right.equalToSuperview().inset(16.auto).priority(.high)
        }
        
        infoView.add(to: self).snp.makeConstraints {
            $0.edges.equalTo(imageView)
        }
        
    }
    
    private func setCornerRadius(_ radius: CGFloat, for corners: UIRectCorner, of view: UIView) {
        let maskPath = UIBezierPath(roundedRect: view.bounds,
                                    byRoundingCorners: corners,
                                    cornerRadii: .init(width: radius, height: radius))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = view.bounds
        maskLayer.path = maskPath.cgPath
        view.layer.mask = maskLayer
    }
    
    func updateProfile(profile: ZJUserProfile) {
        
        let level = UserMembershipLevel(string: profile.membershipLevel) ?? .normal
        gadientView.colors = [UIColor(white: 1, alpha: 0), level.shadowColor]
        imageView.image = .named(level.bottomviewBgImageName)
        infoView.refresh(profile: profile)
        
    }
    
}

private class _GradientView: UIView {
    
    override class var layerClass: AnyClass { CAGradientLayer.self }
    
    var colors: [UIColor] = [] {
        didSet {
            (layer as! CAGradientLayer).colors = colors.map { $0.cgColor }
            (layer as! CAGradientLayer).locations = [NSNumber(value: 0), NSNumber(value: 1)]
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let gradientLayer = layer as! CAGradientLayer
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint   = CGPoint(x: 0, y: 1)
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError() }
}

private extension UserMembershipLevel {
    
    var shadowColor: UIColor {
        switch self {
        case .normal:
            return .init(hexString: "#E8C1A8", alpha: 0.34)
        case .copper:
            return .init(hexString: "#DAF3F3", alpha: 0.35)
        case .silver:
            return .init(hexString: "#D5D5D5", alpha: 0.23)
        case .gold:
            return .init(hexString: "#E8C1A8", alpha: 0.34)
        case .platinum:
            return .init(hexString: "#DCDFF1", alpha: 1.00)
        case .diamond:
            return .init(hexString: "#261234", alpha: 0.11)
        }
    }
    
    var topviewImageName: String {
        switch self {
        case .normal:   return "main_level_num1_icon"
        case .copper:   return "main_level_num2_icon"
        case .silver:   return "main_level_num3_icon"
        case .gold:     return "main_level_num4_icon"
        case .platinum: return "main_level_num5_icon"
        case .diamond:  return "main_level_num6_icon"
        }
    }
    
    var bottomviewBgImageName: String {
        switch self {
        case .normal:   return "main_level_num1_bgimg"
        case .copper:   return "main_level_num2_bgimg"
        case .silver:   return "main_level_num3_bgimg"
        case .gold:     return "main_level_num4_bgimg"
        case .platinum: return "main_level_num5_bgimg"
        case .diamond:  return "main_level_num6_bgimg"
        }
    }
    
}

/*
private extension ParticipateLevel {
    
    var participateLevelImageName: String {
        switch self {
        case .normal:
            return ""
        case .platinum:
            switch ZJLa.Language.current {
            case .en:
                return "participate_platinum_en"
            case .id:
                return "participate_platinum_id"
            }
        case .diamond:
            switch ASLanguage.Language.current {
            case .en:
                return "participate_diamond_en"
            case .id:
                return "participate_diamond_id"
            }
        }
    }
    
}
 */
                                            
