//
//  RefreshViewController.swift
//  ZJPersonal
//
//  Created by Jercan on 2023/12/15.
//

import UIKit
import JXSegmentedView
import JXPagingView
import RxSwift

class RefreshViewController: BaseVC {
    
    private lazy var titles: [String] = ["王二", "彭三", "龙四", "黄五"]
    
    private lazy var dataSource = JXSegmentedTitleDataSource().then {
        $0.titles = titles
        $0.isTitleColorGradientEnabled = true 
    }
    
    private lazy var indicator = JXSegmentedIndicatorLineView().then {
        $0.lineStyle = .lengthen
    }
    
    private lazy var segmentView = JXSegmentedView().then {
        $0.dataSource = dataSource
        $0.indicators = [indicator]
        $0.listContainer = pagingView.listContainerView
    }
    
    private lazy var pagingView = JXPagingView(delegate: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        bindViewModel()
    }
    
    
}

private extension RefreshViewController {
    
    func setupViews() {
        
        pagingView.add(to: view).snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
    }
    
    func bindViewModel() {
        
        // tableView.rx.addRefreshHeader.bind(to: viewModel.reloadAction.inputs).disposed(by: disposeBag)
        pagingView.mainTableView.rx.addRefreshHeader.subscribe(onNext: { [weak self] in
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self?.pagingView.mainTableView.endPullToRefresh()
            }
            
        }).disposed(by: disposeBag)
        
    }
    
}

extension RefreshViewController: JXPagingViewDelegate {
    
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
        segmentView
    }
    
    func numberOfLists(in pagingView: JXPagingView) -> Int {
        titles.count
    }
    
    func pagingView(_ pagingView: JXPagingView, initListAtIndex index: Int) -> JXPagingViewListViewDelegate {
        ListViewController()
    }
    
}
