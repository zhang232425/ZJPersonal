//
//  ZJPersonalSection.swift
//  ZJPersonal
//
//  Created by Jercan on 2023/12/1.
//

import Foundation

enum ZJPersonalSection {
    
    /// 我的RM
    case relationship
    
    /// RM业绩管理
    case performance
    
    /// 在线会话
    case helperChat
    
    /// 设置
    case settings
    
}

extension ZJPersonalSection: CommonResponderEvent {}

extension ZJPersonalSection {
    
    var title: String {
        switch self {
        case .relationship:
            return Locale.main_item_rm.localized
        case .performance:
            return Locale.main_item_performance.localized
        case .helperChat:
            return Locale.main_item_chat.localized
        case .settings:
            return Locale.main_item_setting.localized
        }
    }
    
    var imageName: String {
        switch self {
        case .relationship:
            return "main_list_item_rm"
        case .performance:
            return "main_list_item_rm"
        case .helperChat:
            return "main_list_item_chat"
        case .settings:
            return "main_list_item_settings"
        }
    }
    
}
