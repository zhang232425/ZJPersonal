//
//  ZJPersonalVM.swift
//  ZJPersonal
//
//  Created by Jercan on 2023/12/1.
//

import Foundation
import RxSwift
import RxCocoa
import ZJLoginManager
import Action
import ZJCommonDefines

final class ZJPersonalVM {
    
    private let disposeBag = DisposeBag()
    
    private let isLogin = BehaviorRelay(value: false)

    private let sections = BehaviorRelay<[ZJPersonalSection]>(value: [])
    
    private(set) lazy var inviteCouponNoticeAction: Action<(), String> = .init {
        Request.main.inviteCouponNotice()
    }
    
    private(set) lazy var profileAction: Action<Bool, ZJUserProfile> = .init {
        if $0 {
            return Request.main.fetchUserProfile().asObservable()
        }
        if let data = ZJLoginManager.shared.profile, ZJLoginManager.shared.isLogin {
            return .just(data)
        }
        return Request.main.fetchUserProfile().asObservable()
    }
    
    private(set) lazy var unreadMsgCountAction: Action<(), Int> = .init {
        if ZJLoginManager.shared.isLogin {
            return Request.main.getUnreadMessageCount()
        }
        return .just(0)
    }
    
    private(set) lazy var unUsedCouponsAction: Action<(), Int> = .init {
        if ZJLoginManager.shared.isLogin {
            return Request.main.getUnreadCouponCount()
        }
        return .just(0)
    }
    
    private(set) lazy var hasUnReadChatMsgAction: Action<(), Bool> = .init {
        if ZJLoginManager.shared.isLogin {
            return Request.main.hasUnReadChatMessage().asObservable()
        }
        return .just(false)
    }

    init() {
        initActions()
        setupData()
        registerNotifications()
    }
    
}

private extension ZJPersonalVM {
    
    func initActions() {
        
        unreadMsgCountAction = Action<(), Int>(workFactory: { _ -> Observable<Int> in
            if ZJLoginManager.shared.isLogin {
                return Request.main.getUnreadMessageCount().asObservable()
            }
            return .just(0)
        })
        
        unUsedCouponsAction = Action<(), Int>(workFactory: { _ -> Observable<Int> in
            if ZJLoginManager.shared.isLogin {
                return Request.main.getUnreadCouponCount().asObservable()
            }
            return .just(0)
        })
        
    }

    func setupData() {
    
        isLogin.accept(ZJLoginManager.shared.isLogin)
        sections.accept([.relationship, .helperChat, .settings])
        unreadMsgCountAction.execute()
        profileAction.execute(false)
        
        /**
         hasUnReadChatMsgAction = Action<(), Bool>(workFactory: { _ -> Observable<Bool> in
             if ASLoginManager.shared.isLogin {
                 return RxRequest.usermain.hasUnReadChatMsg().asObservable()
             }
             return .just(false)
         })
         */
        
    }
    
    func registerNotifications() {
        
        let didLogin = NotificationCenter.default.rx.notification(ZJNotification.didLoginCompletion)
        let didLogout = NotificationCenter.default.rx.notification(ZJNotification.didLogout)
        let didKickOff = NotificationCenter.default.rx.notification(ZJNotification.didKickOff)
        
        Observable.merge(didLogin.map { _ in ZJLoginManager.shared.profile != nil },
                         didLogout.map { _ in false },
                         didKickOff.map { _ in false })
        .bind(to: isLogin)
        .disposed(by: disposeBag)
        
        didLogin.subscribe(onNext: { [weak self] _ in
            self?.isLogin.accept(true)
            self?.profileAction.execute(false)
            self?.unreadMsgCountAction.execute()
            self?.unUsedCouponsAction.execute()
            self?.hasUnReadChatMsgAction.execute()
        }).disposed(by: disposeBag)
        
        Observable.merge(didLogin, didKickOff).subscribe(onNext: { [weak self] _ in
            self?.unreadMsgCountAction.execute()
            self?.unUsedCouponsAction.execute()
            self?.hasUnReadChatMsgAction.execute()
        }).disposed(by: disposeBag)
        
    }
    
}

extension ZJPersonalVM {
    
    func initRequest() {
        
        inviteCouponNoticeAction.execute()

    }
    
    func requestDatas() {
        
        inviteCouponNoticeAction.execute()
        unUsedCouponsAction.execute()
        unreadMsgCountAction.execute()
        hasUnReadChatMsgAction.execute()
        
        if ZJLoginManager.shared.isLogin {
            profileAction.execute(true)
        }
        
    }
    
}

extension ZJPersonalVM {
    
    var isLoginStateAction: Observable<Bool> { isLogin.asObservable() }
    
    var sectionsAction: Observable<[ZJPersonalSection]> { sections.asObservable() }
    
    var profileData: ZJUserProfile? { ZJLoginManager.shared.profile }
    
    var profileRequestEnd: Observable<()> {
        Observable.merge(profileAction.elements.map{_ in},
                         profileAction.errors.map{_ in})
    }
    
}
