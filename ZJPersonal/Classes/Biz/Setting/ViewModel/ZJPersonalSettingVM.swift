//
//  ZJPersonalSettingVM.swift
//  ZJPersonal
//
//  Created by Jercan on 2023/12/6.
//

import Foundation
import Action

struct ZJPersonalSettingVM {
    
    private(set) lazy var appVersionAction: Action<Void, UpdateInfoModel> = .init {
        Request.Setting.getAppUpdateInfo()
    }
    
    private(set) lazy var logoutAction: Action<(), Bool> = .init {
        Request.Setting.logout()
    }
    
}
