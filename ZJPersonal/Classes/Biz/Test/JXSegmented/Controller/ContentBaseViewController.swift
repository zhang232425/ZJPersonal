//
//  ContentBaseViewController.swift
//  ZJPersonal
//
//  Created by Jercan on 2023/12/14.
//

import UIKit
import JXSegmentedView

/*
class ContentBaseViewController: BaseVC {
    
    private lazy var titles: [String] = ["陈铭", "龙蓉", "彭敏", "王滕", "孙丽雯", "黄英", "张大春"]
    
    private lazy var segmentedView = JXSegmentedView().then {
        $0.dataSource = dataSource
        $0.indicators = [indicator]
        $0.listContainer = listContainerView
    }
    
    private lazy var listContainerView = JXSegmentedListContainerView(dataSource: self)
    
    private lazy var dataSource = JXSegmentedTitleDataSource().then {
        $0.isTitleColorGradientEnabled = true
        $0.titles = titles
    }
    
    private lazy var indicator = JXSegmentedIndicatorLineView().then {
        $0.indicatorWidth = 20
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

}

private extension ContentBaseViewController {
    
    func setupViews() {
        
        segmentedView.add(to: view).snp.makeConstraints {
            $0.left.top.right.equalToSuperview()
            $0.height.equalTo(50.auto)
        }
        
        listContainerView.add(to: view).snp.makeConstraints {
            $0.left.bottom.right.equalToSuperview()
            $0.top.equalTo(segmentedView.snp.bottom)
        }
        
    }
    
}

extension ContentBaseViewController: JXSegmentedListContainerViewDataSource {
    
    func numberOfLists(in listContainerView: JXSegmentedListContainerView) -> Int {
        
        return titles.count
        
    }

    func listContainerView(_ listContainerView: JXSegmentedListContainerView, initListAt index: Int) -> JXSegmentedListContainerViewListDelegate {
        
        return ListBaseViewController()
        
    }
    
}
*/

class ContentBaseViewController: BaseVC {
    
    var indicators: [JXSegmentedIndicatorBaseView] = []
    
    var dataSource: JXSegmentedBaseDataSource?
    
    lazy var segmentedView = JXSegmentedView()
    
    private lazy var listContainerView = JXSegmentedListContainerView(dataSource: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
        setupViews()
    }
    
}

private extension ContentBaseViewController {
    
    func config() {
        
        segmentedView.indicators = indicators
        segmentedView.dataSource = dataSource
        segmentedView.listContainer = listContainerView
        
    }
    
    func setupViews() {
        
        segmentedView.add(to: view).snp.makeConstraints {
            $0.left.top.right.equalToSuperview()
            $0.height.equalTo(50.auto)
        }
        
        listContainerView.add(to: view).snp.makeConstraints {
            $0.left.bottom.right.equalToSuperview()
            $0.top.equalTo(segmentedView.snp.bottom)
        }
        
    }
    
}

extension ContentBaseViewController: JXSegmentedListContainerViewDataSource {
    
    func numberOfLists(in listContainerView: JXSegmentedListContainerView) -> Int {
        
        if let dataSource = dataSource {
            return dataSource.dataSource.count
        }
        
        return 0
        
    }

    func listContainerView(_ listContainerView: JXSegmentedListContainerView, initListAt index: Int) -> JXSegmentedListContainerViewListDelegate {
        
        return ListBaseViewController()
        
    }
    
}
