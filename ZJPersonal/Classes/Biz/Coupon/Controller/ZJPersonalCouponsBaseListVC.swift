//
//  ZJPersonalCouponsBaseListVC.swift
//  ZJPersonal
//
//  Created by Jercan on 2023/12/7.
//

import UIKit
import JXPagingView

class ZJPersonalCouponsBaseListVC: BaseVC {
    
    private var listViewDidScrollCallBack: ((UIScrollView) -> ())?

    private(set) lazy var tableView = UITableView().then {
        $0.separatorStyle = .none
        $0.estimatedRowHeight = 100
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

extension ZJPersonalCouponsBaseListVC: UITableViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        listViewDidScrollCallBack?(scrollView)
    }
    
}

extension ZJPersonalCouponsBaseListVC: JXPagingViewListViewDelegate {
    
    func listView() -> UIView {
        view
    }
    
    func listScrollView() -> UIScrollView {
        tableView
    }
    
    func listViewDidScrollCallback(callback: @escaping (UIScrollView) -> ()) {
        listViewDidScrollCallBack = callback
    }
    
}
