//
//  MembershipInfoView.swift
//  ZJPersonal
//
//  Created by Jercan on 2023/12/4.
//

import UIKit
import ZJLoginManager

class ZJMembershipInfoView: BaseView {

    private lazy var titleLabel = UILabel().then {
        $0.textColor = .black
        $0.font = .bold16
        $0.textAlignment = .left
        $0.numberOfLines = 1
    }
    
    private lazy var levelLabel = UILabel().then {
        $0.textColor = .black
        $0.font = .regular11
        $0.numberOfLines = 1
    }
    
    private lazy var descLabel = UILabel().then {
        $0.textColor = .black
        $0.font = .regular12
        $0.numberOfLines = 0
    }
    
    private lazy var progressView = CommonProgressView()
    
    private lazy var imageView = UIImageView()
    
    private lazy var button = UIButton(type: .custom).then {
        $0.backgroundColor = UIColor(hexString: "8D4E3C")
        $0.titleLabel?.font = .systemFont(ofSize: 14, weight: .bold)
        $0.contentEdgeInsets = .init(top: 0, left: 18, bottom: 0, right: 18)
        $0.setTitleColor(.white, for: .normal)
        $0.setTitle(Locale.go.localized, for: .normal)
        $0.isUserInteractionEnabled = false
        $0.layer.cornerRadius = 13.auto
        $0.layer.masksToBounds = true
    }
    
    override func setupViews() {
        
        titleLabel.add(to: self).snp.makeConstraints {
            $0.top.left.equalToSuperview().inset(16.auto)
            $0.right.equalToSuperview().inset(75.auto)
        }
        
        progressView.add(to: self).snp.makeConstraints {
            $0.left.equalToSuperview().inset(16.auto)
            $0.top.equalTo(titleLabel.snp.bottom).offset(10.auto)
            $0.width.equalToSuperview().multipliedBy(0.2)
            $0.height.equalTo(3.auto)
        }
        
        levelLabel.add(to: self).snp.makeConstraints {
            $0.left.equalTo(progressView.snp.right).offset(6.auto)
            $0.right.equalToSuperview().inset(75.auto)
            $0.centerY.equalTo(progressView)
        }
        
        descLabel.add(to: self).snp.makeConstraints {
            $0.left.equalToSuperview().inset(16.auto)
            $0.right.equalToSuperview().inset(86.auto)
            $0.top.equalTo(levelLabel.snp.bottom).offset(12.auto)
        }
        
        imageView.add(to: self).snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.right.equalToSuperview().inset(19.auto)
            $0.size.equalTo(CGSize(width: 51.auto, height: 56.auto))
        }
        
        button.add(to: self).snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(14.auto).priority(.high)
            $0.right.equalToSuperview().inset(13.auto)
            $0.width.greaterThanOrEqualTo(68.auto)
            $0.height.equalTo(26.auto)
            $0.bottom.equalToSuperview().inset(16.auto)
        }
    
    }
    
    func refresh(profile: ZJUserProfile) {
        
        let level = UserMembershipLevel(string: profile.membershipLevel) ?? .normal
        titleLabel.textColor = level.mainTextColor
        levelLabel.textColor = level.mainTextColor
        descLabel.textColor = level.descTextColor
        progressView.progressColor = level.mainTextColor
        progressView.normalColor = level.progressBgColor
        button.backgroundColor = level.buttonBgColor
        
        titleLabel.text = profile.memberLevelTitle
        descLabel.text  = profile.memberLevelDesc
        imageView.image = .named(level.insigniaImageName)
        
        configProgress(profile)
    }
    
    private func configProgress(_ profile: ZJUserProfile) {
        
        let current  = Double(profile.currentWealth) ?? 0
        let maxValue = Double(profile.highestWealthOfCurrentLevel) ?? 0
        let highest  = max(1, maxValue)
        progressView.progress = CGFloat(current / highest)
        levelLabel.text = profile.currentWealth + " / " + profile.highestWealthOfCurrentLevel
        
        let noProgress = current == 0 || maxValue == 0
        progressView.isHidden = noProgress
        levelLabel.isHidden = noProgress
    }

}

private extension UserMembershipLevel {
    
    var mainTextColor: UIColor {
        switch self {
        case .normal:
            return .init(hexString: "#8D4E3C")
        case .copper:
            return .init(hexString: "#1C6B6A")
        case .silver:
            return .init(hexString: "#615F5F")
        case .gold:
            return .init(hexString: "#7B4913")
        case .platinum:
            return .init(hexString: "#2E405E")
        case .diamond:
            return .white
        }
    }
    
    var descTextColor: UIColor {
        switch self {
        case .normal:
            return .init(hexString: "#8D4E3C")
        case .copper:
            return .init(hexString: "#1C6B6A")
        case .silver:
            return .init(hexString: "#615F5F")
        case .gold:
            return .init(hexString: "#7B4913")
        case .platinum:
            return .init(hexString: "#2E405E")
        case .diamond:
            return UIColor.white.withAlphaComponent(0.8)
        }
    }
    
    var progressBgColor: UIColor {
        switch self {
        case .normal:
            return UIColor.white.withAlphaComponent(0.5)
        case .copper:
            return .init(hexString: "#1C6B6A", alpha: 0.2)
        case .silver:
            return .init(hexString: "#615F5F", alpha: 0.2)
        case .gold:
            return .init(hexString: "#7B4913", alpha: 0.2)
        case .platinum:
            return .init(hexString: "#2E405E", alpha: 0.2)
        case .diamond:
            return UIColor.white.withAlphaComponent(0.2)
        }
    }
    
    var buttonBgColor: UIColor {
        switch self {
        case .normal:
            return .init(hexString: "#8D4E3C")
        case .copper:
            return .init(hexString: "#1C6B6A")
        case .silver:
            return .init(hexString: "#615F5F")
        case .gold:
            return .init(hexString: "#7B4913")
        case .platinum:
            return .init(hexString: "#2E405E")
        case .diamond:
            return .init(hexString: "#674A80")
        }
    }
    
    var insigniaImageName: String {
        switch self {
        case .normal:
            return "main_menber_level_icon_normal"
        case .copper:
            return "main_menber_level_icon_copper"
        case .silver:
            return "main_menber_level_icon_silver"
        case .gold:
            return "main_menber_level_icon_gold"
        case .platinum:
            return "main_menber_level_icon_pt"
        case .diamond:
            return "main_menber_level_icon_diamond"
        }
    }
}
