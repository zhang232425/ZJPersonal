//
//  ZJPersonalViewController.swift
//  ZJPersonal
//
//  Created by Jercan on 2023/9/5.
//

import UIKit
import RxSwiftExt
import RxSwift
import RxCocoa

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
        
        viewModel.profileAction.elements
            .subscribeNext(weak: scrollView, ZJPersonalScrollView.updateProfile)
            .disposed(by: disposeBag)
        
        if let data = viewModel.profileData {
            scrollView.updateProfile(data)
        }
        
        viewModel.profileRequestEnd
            .bind(to: scrollView.rx.endHeaderRefresh)
            .disposed(by: disposeBag)
        
        /**
         viewModel.unreadMsgCount
             .subscribeNext(weak: unreadMsgView, UnreadMsgIconView.setCount)
             .disposed(by: disposeBag)
         
         viewModel.unUsedCouponCount
             .subscribeNext(weak: scrollView, UserMainScrollView.setUnusedCoupon)
             .disposed(by: disposeBag)
         
         viewModel.hasUnReadChatMsg.subscribe(onNext: { [weak self] in
             self?.scrollView.setHasUnreadChatMsg($0)
             self?.unReadChat = $0
         }).disposed(by: disposeBag)
         
         if let tabBarItem = tabBarController?.tabBar.items?.last {
             Observable.combineLatest(viewModel.isLoginState,
                                      viewModel.unreadMsgCount,
                                      viewModel.hasNewAppVersion)
                 .map { $0 && ($1 > 0 || $2) }
                 .bind(to: tabBarItem.rx.showCustomBadge)
                 .disposed(by: disposeBag)
         }
         */
        
        viewModel.unreadMsgCountAction.elements
            .subscribeNext(weak: unreadMessageView, ZJUnreadMessageView.setCount)
            .disposed(by: disposeBag)
                
        viewModel.unUsedCouponsAction.elements
            .subscribeNext(weak: scrollView, ZJPersonalScrollView.updateUnusedCoupon)
            .disposed(by: disposeBag)
        
        viewModel.hasUnReadChatMsgAction.elements
            .subscribeNext(weak: scrollView, ZJPersonalScrollView.updateHasUnreadChatMsg)
            .disposed(by: disposeBag)
        
        if let tabBarItem = tabBarController?.tabBar.items?.last {
            Observable.combineLatest(viewModel.isLoginStateAction,
                                     viewModel.unreadMsgCountAction.elements)
            .map { $0 && ($1 >= 0) }
            .bind(to: tabBarItem.rx.showCustomBadge)
            .disposed(by: disposeBag)
        }
        
        
        
    }
    
}

private extension ZJPersonalVC {
    
    func handlePull(_ : Void) {
        
        self.viewModel.requestDatas()
        
    }
    
}
