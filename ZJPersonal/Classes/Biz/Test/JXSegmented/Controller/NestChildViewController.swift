//
//  NestChildViewController.swift
//  ZJPersonal
//
//  Created by Jercan on 2023/12/15.
//

import UIKit
import JXSegmentedView

class NestChildViewController: UIViewController {

    private lazy var dataSource = JXSegmentedTitleDataSource().then {
        $0.titles = ["王滕", "陈铭", "龙蓉", "黄英"]
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

private extension NestChildViewController {
    
    func setupViews() {
        
        segmentedView.add(to: view).snp.makeConstraints {
            $0.left.top.right.equalToSuperview()
            $0.height.equalTo(40)
        }
        
        listContainerView.add(to: view).snp.makeConstraints {
            $0.left.bottom.right.equalToSuperview()
            $0.top.equalTo(segmentedView.snp.bottom)
        }
        
    }
    
}

extension NestChildViewController: JXSegmentedListContainerViewDataSource {
    
    func numberOfLists(in listContainerView: JXSegmentedListContainerView) -> Int {
        
        return 4
        
    }

    func listContainerView(_ listContainerView: JXSegmentedListContainerView, initListAt index: Int) -> JXSegmentedListContainerViewListDelegate {
        
        return ListBaseViewController()
        
    }
    
}

extension NestChildViewController: JXSegmentedListContainerViewListDelegate {
    func listView() -> UIView {
        return view
    }
}
