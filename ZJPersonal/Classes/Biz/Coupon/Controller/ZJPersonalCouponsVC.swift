//
//  ZJPersonalCouponsVC.swift
//  ZJPersonal
//
//  Created by Jercan on 2023/12/7.
//

import UIKit
import JXPagingView
import JXSegmentedView

/**
 https://juejin.cn/post/7306384396503089161?searchId=20231207173524C1C25A193009B00EA434
 */

class ZJPersonalCouponsVC: BaseVC {
    
    private let couponStatuses: [CouponModel.Status] = [.available, .used, .expired]
    
    private lazy var contentView = JXPagingListRefreshView(delegate: self)
    
    private lazy var segmentView = ZJSegmentedView().then {
        $0.titles = couponStatuses.map { $0.title }
        $0.listContainer = contentView.listContainerView
        $0.delegate = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }


}

private extension ZJPersonalCouponsVC {
    
    func setupViews() {
        
        navigationItem.title = Locale.coupons.localized
        
        segmentView.add(to: view).snp.makeConstraints {
            $0.top.equalToSafeArea(of: view)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(40.auto)
        }
        
        contentView.add(to: view).snp.makeConstraints {
            $0.top.equalTo(segmentView.snp.bottom)
            $0.left.right.equalTo(segmentView)
            $0.bottom.equalToSuperview()
        }
        
    }
    
}

extension ZJPersonalCouponsVC: JXPagingViewDelegate {
    
    func tableHeaderViewHeight(in pagingView: JXPagingView) -> Int {
        return 0
    }
    
    func tableHeaderView(in pagingView: JXPagingView) -> UIView {
        return .init()
    }
    
    func heightForPinSectionHeader(in pagingView: JXPagingView) -> Int {
        return 0
    }
    
    func viewForPinSectionHeader(in pagingView: JXPagingView) -> UIView {
        return .init()
    }
    
    func numberOfLists(in pagingView: JXPagingView) -> Int {
        return couponStatuses.count
    }
    
    func pagingView(_ pagingView: JXPagingView, initListAtIndex index: Int) -> JXPagingViewListViewDelegate {
        return ZJPersonalCouponsListVC(status: couponStatuses[index])
    }
    
}

extension ZJPersonalCouponsVC: JXSegmentedViewDelegate {}

extension JXPagingListContainerView: JXSegmentedViewListContainer {}

