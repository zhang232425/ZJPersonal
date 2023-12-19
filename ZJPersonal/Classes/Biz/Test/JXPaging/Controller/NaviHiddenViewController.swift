//
//  NaviHiddenViewController.swift
//  ZJPersonal
//
//  Created by Jercan on 2023/12/18.
//

import UIKit
import JXPagingView
import JXSegmentedView

class NaviHiddenViewController: BaseVC {
    
    private let height = UIScreen.safeAreaTop + 44
    
    private lazy var naviBGView: UIView = UIView()
    
    private lazy var titles: [String] = ["王二", "彭三", "龙四", "黄五"]
    
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
    
    private lazy var pagingView = JXPagingView(delegate: self)

    override func viewDidLoad() {
        super.viewDidLoad()
        config()
        setupViews()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
}

private extension NaviHiddenViewController {
    
    func config() {
        
//        self.automaticallyAdjustsScrollViewInsets = false
        pagingView.pinSectionHeaderVerticalOffset = Int(88)
        
    }
    
    func setupViews() {
        
        pagingView.add(to: view).snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        //自定义导航栏
        naviBGView.alpha = 0
        naviBGView.backgroundColor = UIColor.white
        naviBGView.frame = CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: height)
        self.view.addSubview(naviBGView)

        let naviTitleLabel = UILabel()
        naviTitleLabel.text = "导航栏隐藏"
        naviTitleLabel.textAlignment = .center
        naviTitleLabel.frame = CGRect(x: 0, y: height - 44, width: self.view.bounds.size.width, height: 44)
        naviBGView.addSubview(naviTitleLabel)

        let back = UIButton(type: .system)
        back.setTitle("返回", for: .normal)
        back.frame = CGRect(x: 12, y: height - 44, width: 44, height: 44)
        back.addTarget(self, action: #selector(naviBack), for: .touchUpInside)
        naviBGView.addSubview(back)
            
        pagingView.pinSectionHeaderVerticalOffset = Int(height)
        
    }
    
    @objc func naviBack() {
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
}

extension NaviHiddenViewController: JXPagingViewDelegate {
    
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
    
    func pagingView(_ pagingView: JXPagingView, mainTableViewDidScroll scrollView: UIScrollView) {
        let thresholdDistance: CGFloat = 100
        var percent = scrollView.contentOffset.y/thresholdDistance
        percent = max(0, min(1, percent))
        naviBGView.alpha = percent
    }
    
}
