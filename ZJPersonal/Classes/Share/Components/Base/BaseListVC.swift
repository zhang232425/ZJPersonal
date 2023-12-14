//
//  BaseTableVC.swift
//  ZJPersonal
//
//  Created by Jercan on 2023/12/13.
//

import UIKit
import RxDataSources

class BaseListVC: BaseVC {
    
    private(set) lazy var tableView = UITableView(frame: .zero, style: .plain).then {
        $0.registerCell(TestCell.self)
        $0.registerCell(SegmentedCell.self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
}

private extension BaseListVC {
    
    func setupViews() {
        
        tableView.add(to: view).snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
    }
    
}
