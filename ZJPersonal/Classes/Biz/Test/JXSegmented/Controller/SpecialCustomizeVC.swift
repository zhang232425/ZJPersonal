//
//  SpecialCustomizeVC.swift
//  ZJPersonal
//
//  Created by Jercan on 2023/12/14.
//

import UIKit
import RxCocoa
import RxSwift
import RxDataSources

class SpecialCustomizeVC: BaseListVC {
    
    private let items: [String] = ["个人主页",
                                   "SegmentedControl",
                                   "导航栏使用",
                                   "嵌套使用",
                                   "刷新数据+JXSegmentedListContainerView",
                                   "刷新数据+列表自定义",
                                   "isItemSpacingAverageEnabled为true",
                                   "isItemSpacingAverageEnabled为false",
                                   "导航栏自定义返回item手势处理",
                                   "自定义：网格cell"]
    
    private let datas = BehaviorRelay(value: [SectionModel<String, String>]())

    init(title: String) {
        super.init(nibName: nil, bundle: nil)
        self.navigationItem.title = title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindDatas()
    }
    
}


private extension SpecialCustomizeVC {
    
    func bindDatas() {
        
        bindListDataSource()
        
        tableView.rx.modelSelected(String.self).subscribeNext(weak: self, SpecialCustomizeVC.rowClick).disposed(by: disposeBag)
        
        datas.accept([SectionModel(model: "", items: items)])
        
    }
    
    func bindListDataSource() {
        
        let dataSource: RxTableViewSectionedReloadDataSource<SectionModel<String, String>> = .init(configureCell: { (ds, tableView, indexPath, item) in
            
            let cell: CustomizeCell = tableView.dequeueReuseableCell(forIndexPath: indexPath)
            cell.update(with: item)
            return cell
            
        })
        
        datas.observe(on: MainScheduler.instance).bind(to: tableView.rx.items(dataSource: dataSource)).disposed(by: disposeBag)
        
    }
    
}

private extension SpecialCustomizeVC {
    
    func rowClick(text: String) {
        
        switch text {
    
        case "个人主页":
            break
            
        case "SegmentedControl":
            let vc = SegmentedControlVC(title: text)
            self.navigationController?.pushViewController(vc, animated: true)
            
        case "导航栏使用":
            break
            
        case "嵌套使用":
            let vc = NestViewController()
            self.navigationController?.pushViewController(vc, animated: true)
            
        case "刷新数据+JXSegmentedListContainerView":
            let vc = LoadDataViewController()
            self.navigationController?.pushViewController(vc, animated: true)
            
        case "isItemSpacingAverageEnabled为true":
            break
            
        case "isItemSpacingAverageEnabled为false":
            break
            
        case "导航栏自定义返回item手势处理":
            break
            
        case "自定义：网格cell":
            break
            
        default:
            break
            
        }
        
    }
    
}
