//
//  TestCell.swift
//  ZJPersonal
//
//  Created by Jercan on 2023/12/13.
//

import UIKit

class TestCell: BaseListCell {
    
    private lazy var titleLabel = UILabel().then {
        $0.font = .bold15
    }
    
    private lazy var arrowImgView = UIImageView().then {
        $0.image = .named("main_info_arrowicon")
    }

    override func setupViews() {
        
        selectionStyle = .none
        
        titleLabel.add(to: contentView).snp.makeConstraints {
            $0.left.equalToSuperview().inset(15.auto)
            $0.centerY.equalToSuperview()
            $0.top.bottom.equalToSuperview().inset(15.auto)
        }
        
        arrowImgView.add(to: contentView).snp.makeConstraints {
            $0.right.equalToSuperview().inset(16.auto)
            $0.size.equalTo(25.auto)
            $0.centerY.equalToSuperview()
        }
        
    }
    
}

extension TestCell {
    
    func update(with row: TestRow) {
        
        titleLabel.text = row.rawValue
        
    }
    
}
