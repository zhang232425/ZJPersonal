//
//  ZoomViewController.swift
//  ZJPersonal
//
//  Created by Jercan on 2023/12/15.
//

import UIKit
import JXSegmentedView
import JXPagingView

class ZoomViewController: BaseVC {
    
    weak var nestContentScrollView: UIScrollView?    //嵌套demo使用
    
    private let titles: [String] = ["学习", "锻炼", "泡妞"]
    
    private lazy var headerView = ZoomHeaderView()
    
    private lazy var dataSource = JXSegmentedTitleDataSource().then {
        $0.isTitleColorGradientEnabled = true
        $0.titleNormalFont = UIFont.regular15
        $0.titleSelectedFont = UIFont.bold15
        $0.titles = titles
    }
    
    private lazy var indicator = JXSegmentedIndicatorLineView().then {
        $0.lineStyle = .lengthen
    }
        
    private lazy var segmentedView = JXSegmentedView().then {
        $0.dataSource = dataSource
        $0.indicators = [indicator]
        $0.listContainer = pagingView.listContainerView
    }
    
    lazy var pagingView = JXPagingView(delegate: self).then {
        $0.mainTableView.gestureDelegate = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

}

private extension ZoomViewController {
    
    func setupViews() {
        
        pagingView.add(to: view).snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
    }
    
}

extension ZoomViewController: JXPagingViewDelegate {
    
    /// tableHeaderView的高度，因为内部需要比对判断，只能是整型数
    func tableHeaderViewHeight(in pagingView: JXPagingView) -> Int {
        return 200
    }
    
    /// 返回tableHeaderView
    func tableHeaderView(in pagingView: JXPagingView) -> UIView {
        return headerView
    }
    
    /// 返回悬浮HeaderView的高度，因为内部需要比对判断，只能是整型数
    func heightForPinSectionHeader(in pagingView: JXPagingView) -> Int {
        return 50
    }
    
    /// 返回悬浮HeaderView
    func viewForPinSectionHeader(in pagingView: JXPagingView) -> UIView {
        return segmentedView
    }
    
    /// 返回列表的数量
    func numberOfLists(in pagingView: JXPagingView) -> Int {
        return titles.count
    }
    
    func pagingView(_ pagingView: JXPagingView, initListAtIndex index: Int) -> JXPagingViewListViewDelegate {
        return ListViewController()
    }
    
    func pagingView(_ pagingView: JXPagingView, mainTableViewDidScroll scrollView: UIScrollView) {
        headerView.scrollViewDidScroll(contentOffsetY: scrollView.contentOffset.y)
    }
    
}

extension ZoomViewController: JXSegmentedListContainerViewListDelegate {
    
    func listView() -> UIView {
        return view
    }
    
}

extension ZoomViewController: JXPagingMainTableViewGestureDelegate {
    
    func mainTableViewGestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        
        //禁止Nest嵌套效果的时候，上下和左右都可以滚动
        if otherGestureRecognizer.view == nestContentScrollView {
            return false
        }
        
        //禁止segmentedView左右滑动的时候，上下和左右都可以滚动
        if otherGestureRecognizer == segmentedView.collectionView.panGestureRecognizer {
            return false
        }
        
        return gestureRecognizer.isKind(of: UIPanGestureRecognizer.self) && otherGestureRecognizer.isKind(of: UIPanGestureRecognizer.self)
        
    }
    
    
}
