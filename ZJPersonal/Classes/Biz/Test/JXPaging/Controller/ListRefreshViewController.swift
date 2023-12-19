//
//  ListRefreshViewController.swift
//  ZJPersonal
//
//  Created by Jercan on 2023/12/18.
//

import UIKit
import JXPagingView
import JXSegmentedView

class ListRefreshViewController: BaseVC {
    
    private lazy var titles: [String] = ["王二", "彭三", "龙四", "黄五"]
    
    private lazy var dataSource = JXSegmentedTitleDataSource().then {
        $0.isTitleColorGradientEnabled = true
        $0.titles = titles
    }
    
    private lazy var indicator = JXSegmentedIndicatorLineView().then {
        $0.lineStyle = .lengthen
    }
    
    private lazy var segmentedView = JXSegmentedView().then { // indicators
        $0.dataSource = dataSource
        $0.indicators = [indicator]
        $0.listContainer = pagingView.listContainerView
    }
    
    private lazy var pagingView = JXPagingListRefreshView(delegate: self)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
}

private extension ListRefreshViewController {
    
    func setupViews() {
        
        pagingView.add(to: view).snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
    }
    
}

extension ListRefreshViewController: JXPagingViewDelegate {
    
    func tableHeaderViewHeight(in pagingView: JXPagingView) -> Int {
        200
    }
    
    func tableHeaderView(in pagingView: JXPagingView) -> UIView {
        ZoomHeaderView()
    }
    
    func heightForPinSectionHeader(in pagingView: JXPagingView) -> Int {
        50
    }
    
    func viewForPinSectionHeader(in pagingView: JXPagingView) -> UIView {
        segmentedView
    }
    
    func numberOfLists(in pagingView: JXPagingView) -> Int {
        titles.count
    }
    
    func pagingView(_ pagingView: JXPagingView, initListAtIndex index: Int) -> JXPagingViewListViewDelegate {
        ListViewController()
    }
    
}
