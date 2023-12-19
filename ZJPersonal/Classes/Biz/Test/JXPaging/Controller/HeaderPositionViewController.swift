//
//  HeaderPositionViewController.swift
//  ZJPersonal
//
//  Created by Jercan on 2023/12/18.
//

import UIKit
import JXPagingView
import JXSegmentedView

class HeaderPositionViewController: BaseVC {
    
    private lazy var titles = ["学习", "锻炼", "泡妞"]
    
    private lazy var dataSource = JXSegmentedTitleDataSource().then {
        $0.titles = titles
        $0.isTitleColorGradientEnabled = true
    }
    
    private lazy var indicator = JXSegmentedIndicatorLineView().then {
        $0.lineStyle = .lengthen
    }
    
    private lazy var segmentedView = JXSegmentedView().then {
        $0.dataSource = dataSource
        $0.indicators = [indicator]
        $0.listContainer = pagingView.listContainerView
    }
    
    private lazy var pagingView = JXPagingView(delegate: self).then {
        $0.mainTableView.gestureDelegate = self
        $0.pinSectionHeaderVerticalOffset = 150
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

}

private extension HeaderPositionViewController {
    
    func setupViews() {
        
        pagingView.add(to: view).snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
    }
    
}

extension HeaderPositionViewController: JXPagingViewDelegate {
    
    func tableHeaderViewHeight(in pagingView: JXPagingView) -> Int {
        250
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

extension HeaderPositionViewController: JXPagingMainTableViewGestureDelegate {
    
    func mainTableViewGestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        
        if otherGestureRecognizer == segmentedView.collectionView.panGestureRecognizer {
            return false
        }
        
        return gestureRecognizer.isKind(of: UIPanGestureRecognizer.self) && otherGestureRecognizer.isKind(of: UIPanGestureRecognizer.self)
        
    }
    
}
