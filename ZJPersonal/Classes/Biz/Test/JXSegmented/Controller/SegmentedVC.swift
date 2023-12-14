//
//  JXSegmentedVC.swift
//  ZJPersonal
//
//  Created by Jercan on 2023/12/13.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import RxSwiftExt

class SegmentedVC: BaseListVC {
    
    private let viewModel = SegmentedVM()
    
    private var dataSource: RxTableViewSectionedReloadDataSource<SectionModel<String, SegmentedRow>>!
    
    init(title: String) {
        super.init(nibName: nil, bundle: nil)
        self.navigationItem.title = title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        bindViewModel()
    }
    
}

private extension SegmentedVC {
    
    func setupViews() {
        
        navigationItem.title = "JXSegmented"
            
    }
    
    func bindViewModel() {
        
        bindTableViewDataSource()
        
        tableView.rx.modelSelected(SegmentedRow.self).subscribeNext(weak: self, SegmentedVC.rowClick).disposed(by: disposeBag)
        
    }
    
    func bindTableViewDataSource() {
        
        dataSource = .init(configureCell: { (ds, tableView, indexPath, row) in
            
            let cell: SegmentedCell = tableView.dequeueReuseableCell(forIndexPath: indexPath)
            cell.update(with: row)
            return cell
            
        })
    
        viewModel.datas.observe(on: MainScheduler.instance).bind(to: tableView.rx.items(dataSource: dataSource)).disposed(by: disposeBag)
        
    }
    
}

private extension SegmentedVC {
    
    func rowClick(row: SegmentedRow) {
        
        self.navigationController?.pushViewController(row.vc, animated: true)
        
    }
    
}
