//
//  BaseTableViewCell.swift
//  ZJPersonal
//
//  Created by Jercan on 2023/12/6.
//

import UIKit

class BaseListCell: UITableViewCell {

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {}
    
}
