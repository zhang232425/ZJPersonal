//
//  TestVC.swift
//  ZJPersonal
//
//  Created by Jercan on 2023/12/1.
//

import UIKit
import RxSwift
import RxSwiftExt
import RxDataSources

class TestVC: BaseVC {
    
    private var dataSource: RxTableViewSectionedReloadDataSource<SectionModel<String, TestRow>>!
    
    private let viewModel = TestVM()
    
    private lazy var tableView = UITableView(frame: .zero, style: .plain).then {
        $0.registerCell(TestCell.self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        bindViewModel()
    }
    
}

private extension TestVC {
    
    func setupViews() {
        
        self.navigationItem.title = "Test"
        
        tableView.add(to: view).snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
    }
    
    func bindViewModel() {
        
        bindTableViewDataSource()
    
        tableView.rx.modelSelected(TestRow.self).subscribeNext(weak: self, TestVC.rowClick).disposed(by: disposeBag)
        
    }
    
    func bindTableViewDataSource() {
        
        dataSource = .init(configureCell: { (ds, tableView, indexPath, row) in
            
            let cell: TestCell = tableView.dequeueReuseableCell(forIndexPath: indexPath)
            cell.update(with: row)
            return cell
            
        })
        
        viewModel.datas.observe(on: MainScheduler.instance)
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
    }
    
}

private extension TestVC {
    
    func rowClick(row: TestRow) {
        
        self.navigationController?.pushViewController(row.vc, animated: true)
        
    }
    
}
