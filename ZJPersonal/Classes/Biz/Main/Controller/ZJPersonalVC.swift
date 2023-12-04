//
//  ZJPersonalViewController.swift
//  ZJPersonal
//
//  Created by Jercan on 2023/9/5.
//

import UIKit
import RxSwiftExt
import RxSwift

class ZJPersonalVC: BaseVC {
    
    private let viewModel = ZJPersonalVM()
    
    private lazy var scrollView = ZJPersonalScrollView()
    
    private lazy var unreadMessageView = ZJUnreadMessageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        bindViewModel()
        viewModel.initRequest()
    }
    
}

private extension ZJPersonalVC {
    
    func setupViews() {
        
        view.backgroundColor = UIColor(hexString: "#F3F3F3")
        navigationItem.rightBarButtonItem = .init(customView: unreadMessageView)
        navigationController?.navigationBar.shadowImage = .init()
        navigationController?.navigationBar.isTranslucent = false
        
        scrollView.add(to: view).snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
    }
    
    func bindViewModel() {
        
        scrollView.rx.addRefreshHeader
            .subscribeNext(weak: self, type(of: self).handlePull)
            .disposed(by: disposeBag)
        
        viewModel.isLoginStateAction
            .subscribeNext(weak: scrollView, ZJPersonalScrollView.updateUI)
            .disposed(by: disposeBag)
        
        viewModel.sectionsAction
            .subscribeNext(weak: scrollView, ZJPersonalScrollView.updateSections)
            .disposed(by: disposeBag)
        
        viewModel.inviteCouponNoticeAction.elements
            .subscribeNext(weak: scrollView, ZJPersonalScrollView.updateCouponNotice)
            .disposed(by: disposeBag)
        
        Observable.merge(viewModel.inviteCouponNoticeAction.elements.map { _ in },
                         viewModel.inviteCouponNoticeAction.errors.map { _ in })
            .bind(to: scrollView.rx.endHeaderRefresh)
            .disposed(by: disposeBag)
        
    }
    
}

private extension ZJPersonalVC {
    
    func handlePull(_ : Void) {
        
        self.viewModel.requestDatas()
        
    }
    
}
