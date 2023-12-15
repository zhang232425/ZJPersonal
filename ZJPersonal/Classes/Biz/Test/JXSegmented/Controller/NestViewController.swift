//
//  NestViewController.swift
//  ZJPersonal
//
//  Created by Jercan on 2023/12/15.
//

import UIKit
import JXSegmentedView

class NestViewController: BaseVC {
    
    private lazy var dataSource = JXSegmentedTitleDataSource().then {
        $0.titles = ["张云峰", "张大春"]
    }
    
    private lazy var indicator = JXSegmentedIndicatorLineView().then {
        $0.lineStyle = .lengthen
    }
    
    private lazy var listContainerView = JXSegmentedListContainerView(dataSource: self)
    
    // indicators
    private lazy var segmentedView = JXSegmentedView().then {
        $0.dataSource = dataSource
        $0.listContainer = listContainerView
        $0.indicators = [indicator]
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
        
}

private extension NestViewController {
    
    func setupViews() {
        
        self.navigationItem.title = "嵌套使用"
        
        segmentedView.add(to: view).snp.makeConstraints {
            $0.left.top.right.equalToSuperview()
            $0.height.equalTo(40.auto)
        }
        
        listContainerView.add(to: view).snp.makeConstraints {
            $0.left.bottom.right.equalToSuperview()
            $0.top.equalTo(segmentedView.snp.bottom)
        }
        
    }
    
}

extension NestViewController: JXSegmentedListContainerViewDataSource {
    
    
    func numberOfLists(in listContainerView: JXSegmentedListContainerView) -> Int {
        
        return 2
        
    }

    func listContainerView(_ listContainerView: JXSegmentedListContainerView, initListAt index: Int) -> JXSegmentedListContainerViewListDelegate {
        
        return NestChildViewController()
        
    }
    
}
