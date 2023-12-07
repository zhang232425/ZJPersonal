//
//  SettingLogoutCell.swift
//  ZJPersonal
//
//  Created by Jercan on 2023/12/6.
//

import UIKit

class SettingLogoutCell: BaseTableViewCell {
    
    private lazy var titleLabel = UILabel().then {
        $0.font = .medium16
        $0.textColor = .init(hexString: "FA780A")
        $0.textAlignment = .center
    }

    override func setupViews() {
        
        titleLabel.add(to: contentView).snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
        
    }
    
}

extension SettingLogoutCell {
    
    func setRowInfo(_ row: ZJPersonalSettingVC.Row) {
        titleLabel.text = row.title
    }
    
}
