//
//  ZJPersonalCouponCell.swift
//  ZJPersonal
//
//  Created by Jercan on 2023/12/7.
//

import UIKit

class ZJPersonalCouponCell: BaseListCell {
    
    private let orangeColor = UIColor(hexString: "#FF7D0F")
    
    private lazy var topLine = UIView().then {
        $0.backgroundColor = UIColor(hexString: "#3FCD99")
    }
    
    private lazy var packageBadgeView = GiftTagView().then {
        $0.isHidden = true
    }
    
    private lazy var foregroundView = UIView()
    
    private lazy var iconImageView = UIImageView()
    
    private lazy var titleLabel = UILabel().then {
        $0.font = .bold18
        $0.textColor = UIColor(hexString: "333333")
        $0.adjustsFontSizeToFitWidth = true
    }
    
    private lazy var typeLabel = UILabel().then {
        $0.font = .medium11
        $0.textColor = UIColor(hexString: "333333")
    }
    
    private lazy var descLabel = UILabel().then {
        $0.font = .regular12
        $0.textColor = UIColor(hexString: "666666")
        $0.numberOfLines = 0
    }
    
    private lazy var expireTimeLabel = UILabel().then {
        $0.font = .regular12
        $0.textColor = UIColor(hexString: "666666")
    }
    
    private lazy var useButton = UIButton(type: .custom).then {
        $0.setTitleColor(orangeColor, for: .normal)
        $0.setBackgroundImage(UIImage(color: orangeColor.withAlphaComponent(0.05)), for: .normal)
        $0.setBackgroundImage(UIImage(color: orangeColor.withAlphaComponent(0.30)), for: .highlighted)
        $0.contentEdgeInsets = .init(top: 0, left: 16, bottom: 0, right: 16)
        $0.titleLabel?.font = .medium12
        $0.titleLabel?.textAlignment = .center
        $0.titleLabel?.adjustsFontSizeToFitWidth = true
        $0.layer.borderColor = orangeColor.cgColor
        $0.layer.borderWidth = 1
        $0.addTarget(self, action: #selector(useClicked), for: .touchUpInside)
        $0.setTitle(Locale.useNow.localized, for: .normal)
    }
    
    private lazy var unavailableStateView = _StateView()
    
    private lazy var separatorImageView = UIImageView().then {
        $0.image = .named("img_coupon_line")
    }
    
    private lazy var waterMarkImageView = UIImageView().then {
        $0.image = .named("img_coupon_watermark")
    }

    override func setupViews() {
        
        backgroundColor = UIColor(hexString: "F0F0F2")
        selectionStyle = .none
        
        let _backgroundView = UIView().then {
            $0.backgroundColor = .white
            $0.layer.cornerRadius = 6.auto
        }
        
        _backgroundView.add(to: contentView).snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(16.auto)
            $0.top.bottom.equalToSuperview().inset(6.auto)
        }
        
        let topLineContainerView = UIView().then {
            $0.backgroundColor = .clear
            $0.layer.cornerRadius = 6.auto
            $0.layer.masksToBounds = true
        }
        
        topLineContainerView.add(to: _backgroundView).snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.right.equalToSuperview()
            $0.height.equalTo(20.auto)
        }
    
        topLine.add(to: topLineContainerView).snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.right.equalToSuperview()
            $0.height.equalTo(6.auto)
        }
        
        packageBadgeView.add(to: _backgroundView).snp.makeConstraints {
            $0.left.equalToSuperview()
            $0.top.equalToSuperview().inset(6.auto)
            $0.height.equalTo(18.auto)
        }
        
        foregroundView.add(to: _backgroundView).snp.makeConstraints {
            $0.top.equalToSuperview().inset(16.auto)
            $0.left.right.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        iconImageView.add(to: foregroundView).snp.makeConstraints {
            $0.left.equalToSuperview().inset(16.auto)
            $0.top.equalToSuperview()
            $0.size.equalTo(28.auto)
        }
        
        titleLabel.add(to: foregroundView).snp.makeConstraints {
            $0.left.equalTo(iconImageView.snp.right).offset(12.auto)
            $0.top.equalToSuperview()
        }
    
        titleLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        useButton.setContentCompressionResistancePriority(.required, for: .horizontal)
        useButton.setContentHuggingPriority(.defaultLow, for: .horizontal)
        
        typeLabel.add(to: foregroundView).snp.makeConstraints {
            $0.left.equalTo(titleLabel)
            $0.right.equalToSuperview().inset(18.auto)
            $0.top.equalTo(titleLabel.snp.bottom).offset(4.auto)
        }
        
        descLabel.add(to: foregroundView).snp.makeConstraints {
            $0.left.equalTo(titleLabel)
            $0.top.equalTo(typeLabel.snp.bottom).offset(8.auto)
            $0.right.equalToSuperview().inset(18.auto)
        }
        
        separatorImageView.add(to: foregroundView).snp.makeConstraints {
            $0.top.equalTo(descLabel.snp.bottom).offset(8)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(separatorImageView.snp.width).multipliedBy(0.04878)
        }
        
        expireTimeLabel.add(to: foregroundView).snp.makeConstraints {
            $0.top.equalTo(separatorImageView.snp.bottom).offset(5)
            $0.left.equalToSuperview().inset(56.auto)
            $0.right.equalToSuperview().inset(18.auto)
            $0.bottom.equalToSuperview().inset(12.auto)
        }
        
        useButton.add(to: foregroundView).snp.makeConstraints {
            $0.width.lessThanOrEqualTo(112.auto)
            $0.top.equalToSuperview()
            $0.right.equalToSuperview().inset(16.auto)
            $0.height.equalTo(28.auto)
        }
        useButton.layer.cornerRadius = 28.auto * 0.5
        useButton.layer.masksToBounds = true
        
        titleLabel.snp.makeConstraints {
            $0.right.equalTo(useButton.snp.left).offset(-2.auto)
        }
        
        unavailableStateView.add(to: foregroundView).snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.right.equalToSuperview().inset(-8.auto)
        }
        
        foregroundView.insertSubview(waterMarkImageView, at: 0)
        waterMarkImageView.snp.makeConstraints {
            $0.right.bottom.equalToSuperview()
            $0.size.equalTo(CGSize(width: 114.auto, height: 93.auto))
        }
        
    }
    
    
}

private extension ZJPersonalCouponCell {
    
    @objc func useClicked() {
        
        
        
    }
    
}

extension ZJPersonalCouponCell {
    
    func update(with model: CouponModel) {
        
        let isAvailable = (model.status == .available)
        let date = Date(timeIntervalSince1970: TimeInterval(model.deadline) / 1000)
        let dateString = Date.formatter(with: "dd/MM/yyyy HH:mm").string(from: date)
        
        topLine.isHidden = model.type != .privilege
        topLine.backgroundColor = isAvailable ? .init(hexString: "#3FCD99") : .init(hexString: "#C9CCCF")
        
        iconImageView.image = .named(model.iconImageName)
        waterMarkImageView.isHidden = !isAvailable
        titleLabel.text = model.title
        titleLabel.textColor = isAvailable ? .init(hexString: "#333333") : .init(hexString: "#999999")
        if model.type == .privilege { // 预约券不显示小标题
            typeLabel.text = nil
        } else {
            typeLabel.text = model.subname
        }
        typeLabel.textColor = isAvailable ? .init(hexString: "#333333") : .init(hexString: "#C9CCCF")
        descLabel.text = model.desc
        expireTimeLabel.text = Locale.expirationDate.localized + dateString
        useButton.isHidden = !isAvailable
        unavailableStateView.isHidden = isAvailable
        unavailableStateView.titleLabel.text = model.status?.title
        
        if let package = model.sendType {
            packageBadgeView.isHidden = false
            packageBadgeView.setType(package)
        } else {
            packageBadgeView.isHidden = true
        }
        
        if model.type == .privilege {
            useButton.setTitleColor(.white, for: .normal)
            let image = UIImage.named("privilege_use_btn")?.resizableImage(withCapInsets: UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30))
            useButton.setBackgroundImage(image, for: .normal)
            useButton.setBackgroundImage(image, for: .highlighted)
            useButton.layer.borderColor = UIColor.clear.cgColor
        } else {
            useButton.setTitleColor(orangeColor, for: .normal)
            useButton.setBackgroundImage(UIImage(color: orangeColor.withAlphaComponent(0.05)), for: .normal)
            useButton.setBackgroundImage(UIImage(color: orangeColor.withAlphaComponent(0.30)), for: .highlighted)
            useButton.layer.borderColor = orangeColor.cgColor
        }
        
    }
    
}

fileprivate class GiftTagView: BaseView {
    
    private lazy var icon = UIImageView()
    
    private lazy var label = _GradientBadgeLabel(corners: .init(tl: 8, tr: 0, bl: 0, br: 8)).then {
        $0.colors = [UIColor(hexString: "FFE8AC"), UIColor(hexString: "F1D28F")]
        $0.gradientLayer.startPoint = .init(x: 0, y: 0.5)
        $0.gradientLayer.endPoint = .init(x: 1, y: 0.5)
        $0.textInsets = .init(top: 0, left: 23, bottom: 0, right: 8)
        $0.textColor = UIColor(hexString: "412A00")
        $0.font = .medium10
        $0.textAlignment = .center
    }
    
    override func setupViews() {
        
        label.add(to: self).snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        icon.add(to: self).snp.makeConstraints {
            $0.left.equalToSuperview().inset(8.auto)
            $0.centerY.equalToSuperview()
        }
        
    }
    
    func setType(_ type: CouponModel.Package) {
        label.text = type.title
        icon.image = .named(type.iconImgName)
    }
    
}

fileprivate class _GradientBadgeLabel: BadgeLabel {
    
    override class var layerClass: AnyClass { return CAGradientLayer.self }
    
    var gradientLayer: CAGradientLayer { return layer as! CAGradientLayer }
    
    var colors = [UIColor]() {
        didSet {
            gradientLayer.colors = colors.map { $0.cgColor }
            let stride = 1.0 / Double(colors.count - 1)
//            let numbers = Array(0 ..< colors.count).map { NSNumber(value: Double($0) * stride) }
            let numbers = [Int](0 ..< colors.count).map { NSNumber(value: Double($0) * stride) }
            gradientLayer.locations = numbers
        }
    }
    
}

fileprivate class _StateView: BaseView {
    
    private lazy var imageView = UIImageView().then {
        $0.image = .named("ic_coupon_unavailable_bg")
    }
    
    private(set) lazy var titleLabel = UILabel().then {
        $0.font = .medium12
        $0.textColor = .white
        $0.textAlignment = .center
        $0.adjustsFontSizeToFitWidth = true
    }
    
    override func setupViews() {
        
        imageView.add(to: self).snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalTo(64.auto)
            $0.height.equalTo(30.auto)
        }
        
        titleLabel.add(to: self).snp.makeConstraints {
            $0.top.equalToSuperview().inset(3.auto)
            $0.left.right.equalToSuperview().inset(3.auto)
        }
        
    }
    
}
