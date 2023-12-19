//
//  NestViewController.swift
//  ZJPersonal
//
//  Created by Jercan on 2023/12/18.
//

import UIKit
import JXSegmentedView
import JXPagingView

class PagingNestViewController: BaseVC {
    
    private lazy var titles = ["学习", "锻炼"]
    
    private lazy var dataSource = JXSegmentedTitleDataSource().then {
        $0.titles = titles
        $0.isTitleColorGradientEnabled = true
        $0.itemSpacing = 0
        $0.itemWidth = 80
        $0.titleNormalColor = .black
        $0.titleSelectedColor = .white
        $0.isTitleMaskEnabled = true
    }
    
    private lazy var indicator = JXSegmentedIndicatorBackgroundView().then {
        $0.indicatorColor = .red
        $0.indicatorWidth = 80
        $0.indicatorHeight = 30
        $0.indicatorWidthIncrement = 0
    }
    
    private lazy var segmentView = JXSegmentedView().then {
        $0.dataSource = dataSource
        $0.indicators = [indicator]
        $0.listContainer = containerView
    }
    
    private lazy var containerView = JXSegmentedListContainerView(dataSource: self, type: .scrollView)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
}

private extension PagingNestViewController {
    
    func setupViews() {
        
        segmentView.frame = CGRect(x: 0, y: 0, width: 160, height: 30)
        navigationItem.titleView = segmentView
        
        containerView.add(to: view).snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
    }
    
}

extension PagingNestViewController: JXSegmentedListContainerViewDataSource {
    
    func numberOfLists(in listContainerView: JXSegmentedListContainerView) -> Int {
        2
    }
    
    func listContainerView(_ listContainerView: JXSegmentedListContainerView, initListAt index: Int) -> JXSegmentedListContainerViewListDelegate {
        let vc = ZoomViewController()
        vc.nestContentScrollView = containerView.scrollView
        vc.pagingView.listContainerView.isCategoryNestPagingEnabled = true
        return vc
    }
    
}
