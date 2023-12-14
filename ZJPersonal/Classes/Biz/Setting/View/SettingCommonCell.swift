//
//  SettingCommonCell.swift
//  ZJPersonal
//
//  Created by Jercan on 2023/12/6.
//

import UIKit

class SettingCommonCell: BaseListCell {

    private lazy var titleLabel = UILabel().then {
        $0.font = .regular14
        $0.textColor = UIColor(hexString: "333333")
    }
    
    private lazy var detailLabel = UILabel().then {
        $0.font = .regular12
        $0.textColor = UIColor(hexString: "666666")
        $0.textAlignment = .right
    }
    
    private lazy var iconImgView = UIImageView().then {
        $0.image = .named("ic_arrow_gray_16")
    }

    override func setupViews() {
        
        titleLabel.add(to: contentView).snp.makeConstraints {
            $0.left.equalToSuperview().inset(16.auto)
            $0.centerY.equalToSuperview()
        }
        
        iconImgView.add(to: contentView).snp.makeConstraints {
            $0.right.equalToSuperview().inset(16.auto)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(16.auto)
        }
        
        detailLabel.add(to: contentView).snp.makeConstraints {
            $0.right.equalTo(iconImgView.snp.left).offset(-5.auto)
            $0.left.equalTo(titleLabel.snp.right).offset(5.auto)
            $0.centerY.equalToSuperview()
        }
        
    }

}

extension SettingCommonCell {
    
    func setRowInfo(_ row: ZJPersonalSettingVC.Row) {
        titleLabel.text = row.title
        switch row {
        case .cache(let size):
            detailLabel.text = String(format: "%.0fM", Double(size) / 1024.0 / 1024.0)
        default:
            detailLabel.text = nil
        }
    }
    
}
