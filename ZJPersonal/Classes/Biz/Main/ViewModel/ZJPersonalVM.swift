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

final class ZJPersonalVM {
    
    private let isLogin = BehaviorRelay(value: false)
    
    init() {
        setupData()
    }
    
}

private extension ZJPersonalVM {
    
    func setupData() {
        
        isLogin.accept(ZJLoginManager.shared.isLogin)
        
    }
    
}

extension ZJPersonalVM {
    
    var isLoginState: Observable<Bool> { isLogin.asObservable() }
    
}
