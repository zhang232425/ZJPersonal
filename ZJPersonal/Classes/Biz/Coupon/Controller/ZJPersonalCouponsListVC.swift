//
//  ZJPersonalCouponsListVC.swift
//  ZJPersonal
//
//  Created by Jercan on 2023/12/7.
//

import UIKit
import RxDataSources
import RxSwift

class ZJPersonalCouponsListVC: ZJPersonalCouponsBaseListVC {
        
    private var dataSource: RxTableViewSectionedReloadDataSource<SectionModel<String, ZJPersonalCouponsVM.SectionItem>>!
    
    private let status: CouponModel.Status
    
    private let viewModel: ZJPersonalCouponsVM
    
    init(status: CouponModel.Status) {
        self.status = status
        self.viewModel = .init(status: status)
        super.init(nibName: nil, bundle: nil)
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

private extension ZJPersonalCouponsListVC {
    
    func setupViews() {
        
        tableView.add(to: view).then {
            $0.backgroundColor = UIColor(hexString: "EFEFF4")
            $0.registerCell(ZJPersonalCouponCell.self)
            $0.registerCell(ZJPersonalCouponEmptyCell.self)
            $0.registerCell(NoMoreDataCell.self)
        }.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
    }
    
    func bindViewModel() {
        
        bindTableViewDataSource()
        
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        
        tableView.rx.addRefreshHeader.bind(to: viewModel.reloadAction.inputs).disposed(by: disposeBag)
        
        tableView.rx.addLoadingFooter.bind(to: viewModel.loadMoreAction.inputs).disposed(by: disposeBag)
        
        /**
         tableView.rx.modelSelected(DepositHistoryVM.SectionItem.self).subscribe(onNext: { [weak self] in
             switch $0 {
             case .item(let info):
                 self?.navigationToHistoryDetail(item: info.item)
             default:
                 break
             }
         }).disposed(by: disposeBag)
         */
        
        tableView.rx.modelDeleted(ZJPersonalCouponsVM.SectionItem.self).subscribe(onNext: {
            switch $0 {
            case .item(let model):
                print("model.subname ==== \(model.subname)")
            default:
                break
            }
        }).disposed(by: disposeBag)
        
        viewModel.fetchAction.executing
            .subscribeNext(weak: self, ZJPersonalCouponsListVC.doProgress)
            .disposed(by: disposeBag)
        
        viewModel.fetchAction.errors.map { _ in }
            .delay(.microseconds(300), scheduler: MainScheduler.instance)
            .subscribeNext(weak: self, ZJPersonalCouponsListVC.showNoSignalView)
            .disposed(by: disposeBag)
        
        Observable.merge(viewModel.fetchAction.elements.map { _ in },
                         viewModel.fetchAction.errors.map { _ in },
                         viewModel.reloadAction.elements.map { _ in },
                         viewModel.reloadAction.errors.map { _ in })
        .bind(to: tableView.rx.endHeaderRefresh)
        .disposed(by: disposeBag)
        
        
        Observable.merge(viewModel.fetchAction.errors,
                         viewModel.reloadAction.errors,
                         viewModel.loadMoreAction.errors)
        .subscribeNext(weak: self, ZJPersonalCouponsListVC.doError)
        .disposed(by: disposeBag)
        
        Observable.merge(viewModel.fetchAction.elements,
                         viewModel.reloadAction.elements,
                         viewModel.loadMoreAction.elements,
                         viewModel.fetchAction.errors.map { _ in false },
                         viewModel.reloadAction.errors.map { _ in false },
                         viewModel.loadMoreAction.errors.map { _ in true })
        .bind(to: tableView.rx.endFooterLoading)
        .disposed(by: disposeBag)
        
        viewModel.fetchAction.execute()
        
    }
    
    func bindTableViewDataSource() {
        
        dataSource = .init(configureCell: { (ds, tableView, indexPath, item) in
            
            switch item {
                
            case .item(let model):
                let cell: ZJPersonalCouponCell = tableView.dequeueReuseableCell(forIndexPath: indexPath)
                cell.update(with: model)
                return cell
            
            case .empty:
                let cell: ZJPersonalCouponEmptyCell = tableView.dequeueReuseableCell(forIndexPath: indexPath)
                return cell
                
            case .noMoreData:
                let cell: NoMoreDataCell = tableView.dequeueReuseableCell(forIndexPath: indexPath)
                return cell
                
            }
            
        })
        
        viewModel.datas.observe(on: MainScheduler.instance)
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
    }
    
}

extension ZJPersonalCouponsListVC {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch dataSource[indexPath] {
        case .empty:
            return tableView.bounds.height
        default:
            return UITableViewAutomaticDimension
        }
        
    }
    
}
