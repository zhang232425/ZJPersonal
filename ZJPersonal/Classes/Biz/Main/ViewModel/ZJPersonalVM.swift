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

final class ZJPersonalVM {
    
    private let isLogin = BehaviorRelay(value: false)

    private let sections = BehaviorRelay<[ZJPersonalSection]>(value: [])
    
    private(set) lazy var inviteCouponNoticeAction: Action<(), String> = .init {
        Request.main.inviteCouponNotice()
    }
    
    init() {
        setupData()
    }
    
}

private extension ZJPersonalVM {
    
    func setupData() {
    
        isLogin.accept(ZJLoginManager.shared.isLogin)
        
        refreshSections()
        
    }
    
    func refreshSections() {
        
        /**
         guard ASLoginManager.shared.isLogin, let profile = ASLoginManager.shared.profile else {
             tableItems.accept(.unloginItems)
             return
         }
         
         if let state = profile.rmStatus, state == .open {
             tableItems.accept(.loggedinIsRMItems)
             return
         }
         
         if userRMInfo == nil {
             tableItems.accept(.loggedinNoRMItems)
         } else {
             tableItems.accept(.loggedinHasRMItems)
         }
         */

        sections.accept([.relationship, .helperChat, .settings])
        
    }
    
}

extension ZJPersonalVM {
    
    func initRequest() {
        
        inviteCouponNoticeAction.execute()
        
    }
    
    func requestDatas() {
        
        if ZJLoginManager.shared.isLogin {
            
            inviteCouponNoticeAction.execute()
            
        } else {
            
            inviteCouponNoticeAction.execute()
            
        }
        
    }
    
}

extension ZJPersonalVM {
    
    var isLoginStateAction: Observable<Bool> { isLogin.asObservable() }
    
    var sectionsAction: Observable<[ZJPersonalSection]> { sections.asObservable() }
    
}
