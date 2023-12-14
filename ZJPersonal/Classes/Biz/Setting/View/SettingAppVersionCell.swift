//
//  SettingAppVersionCell.swift
//  ZJPersonal
//
//  Created by Jercan on 2023/12/6.
//

import UIKit

class SettingAppVersionCell: BaseListCell {

    private lazy var titleLabel = UILabel().then {
        $0.font = .regular14
        $0.textColor = UIColor(hexString: "333333")
    }
    
    private lazy var detailLabel = UILabel().then {
        $0.font = .regular12
        $0.textColor = UIColor(hexString: "666666")
        $0.textAlignment = .right
    }
    
    private lazy var badgeView = UIView().then {
        $0.backgroundColor = UIColor(hexString: "FF4D4F")
        let size: CGFloat = 8.auto
        $0.layer.cornerRadius = size * 0.5
        $0.layer.masksToBounds = true
        $0.snp.makeConstraints {
            $0.width.height.equalTo(8.auto)
        }
        $0.isHidden = true
    }
    
    private lazy var arrowImageView = UIImageView().then {
        $0.image = UIImage.named("ic_arrow_gray_16")
        $0.isHidden = true
    }
    
    override func setupViews() {
        
        titleLabel.add(to: contentView).snp.makeConstraints {
            $0.left.equalToSuperview().inset(16.auto)
            $0.centerY.equalToSuperview()
        }
        
        let versionStackView = UIStackView().then {
            $0.spacing = 4.0
            $0.axis = .horizontal
            $0.alignment = .center
        }
        versionStackView.addArrangedSubview(detailLabel)
        versionStackView.addArrangedSubview(badgeView)
        
        let stackView = UIStackView().then {
            $0.spacing = 4.0
            $0.axis = .horizontal
            $0.alignment = .center
        }
        stackView.add(to: contentView).snp.makeConstraints {
            $0.right.equalToSuperview().inset(16.auto)
            $0.centerY.equalToSuperview()
        }
        stackView.addArrangedSubview(versionStackView)
        stackView.addArrangedSubview(arrowImageView)
        
    }

}

extension SettingAppVersionCell {
    
    func setRowInfo(_ row: ZJPersonalSettingVC.Row) {
        titleLabel.text = row.title
        
        switch row {
        case .appVersion(let version, let hasNewVersion):
            detailLabel.text = "V\(version)"
            badgeView.isHidden = !hasNewVersion
            arrowImageView.isHidden = !hasNewVersion
        default:
            detailLabel.text = nil
        }
        
    }
    
}
