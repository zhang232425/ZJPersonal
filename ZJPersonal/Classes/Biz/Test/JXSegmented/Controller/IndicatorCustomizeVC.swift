//
//  IndicatorCustomizeVC.swift
//  ZJPersonal
//
//  Created by Jercan on 2023/12/13.
//

import UIKit
import RxCocoa
import RxDataSources

/**
 * 初始化：https://blog.csdn.net/u010912383/article/details/52895409?spm=1001.2014.3001.5502
 */

class IndicatorCustomizeVC: BaseListVC {
    
    private let items: [String] = ["", ""]

    private let datas = BehaviorRelay(value: [SectionModel<String, String>]())

    init(title: String) {
        super.init(nibName: nil, bundle: nil)
        self.navigationItem.title = title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindDatas()
    }
    
}

private extension IndicatorCustomizeVC {
    
    func bindDatas() {
        
        datas.accept([SectionModel(model: "", items: items)])
        
    }
    
}
