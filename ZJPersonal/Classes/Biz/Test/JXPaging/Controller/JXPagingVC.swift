//
//  JXPagingVC.swift
//  ZJPersonal
//
//  Created by Jercan on 2023/12/14.
//

import UIKit
import RxCocoa
import RxSwift
import RxDataSources

class JXPagingVC: BaseListVC {
    
    private lazy var titles = ["header缩放", "主页下拉刷新&列表上拉加载更多", "列表下拉刷新", "导航栏隐藏", "CategoryView嵌套PagingView", "HeaderView高度改变示例", "HeaderView高度改变示例(动画)", "悬浮Header位置调整", "滚动延续"]
    
    private lazy var datas = BehaviorRelay(value: [SectionModel(model: "", items: titles)])

    private var dataSource: RxTableViewSectionedReloadDataSource<SectionModel<String, String>>!
    
    init(title: String) {
        super.init(nibName: nil, bundle: nil)
        self.navigationItem.title = title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindData()
    }

}

private extension JXPagingVC {
    
    func bindData() {
        
        bindListDataSource()
        
        tableView.rx.modelSelected(String.self).subscribeNext(weak: self, JXPagingVC.rowClick).disposed(by: disposeBag)
        
    }
    
    func bindListDataSource() {
        
        dataSource = .init(configureCell: { (_, tableView, indexPath, item) in
            
            let cell: CustomizeCell = tableView.dequeueReuseableCell(forIndexPath: indexPath)
            cell.update(with: item)
            return cell
            
        })
        
        datas.observe(on: MainScheduler.instance).bind(to: tableView.rx.items(dataSource: dataSource)).disposed(by: disposeBag)
        
    }
    
}

private extension JXPagingVC {
    
    func rowClick(text: String) {
        
        switch text {
            
        case "header缩放":
            let vc = ZoomViewController()
            vc.navigationItem.title = text
            self.navigationController?.pushViewController(vc, animated: true)
            
        case "主页下拉刷新&列表上拉加载更多":
            let vc = RefreshViewController()
            vc.navigationItem.title = text
            self.navigationController?.pushViewController(vc, animated: true)
            
        case "列表下拉刷新":
            let vc = ListRefreshViewController()
            vc.navigationItem.title = text
            self.navigationController?.pushViewController(vc, animated: true)
            
        case "导航栏隐藏":
            let vc = NaviHiddenViewController()
            vc.navigationItem.title = text
            self.navigationController?.pushViewController(vc, animated: true)
            
        case "CategoryView嵌套PagingView":
            let vc = PagingNestViewController()
            self.navigationController?.pushViewController(vc, animated: true)
            
        case "HeaderView高度改变示例":
            let vc = HeightChangeViewController()
            vc.navigationItem.title = text
            self.navigationController?.pushViewController(vc, animated: true)
            
        case "HeaderView高度改变示例(动画)":
            break
            
        case "悬浮Header位置调整":
            let vc = HeaderPositionViewController()
            vc.navigationItem.title = text
            self.navigationController?.pushViewController(vc, animated: true)
            
        case "滚动延续":
            break
            
        default:
            break
            
        }
        
    }
    
}
