//
//  UserMembershipLevel.swift
//  ZJPersonal
//
//  Created by Jercan on 2023/12/4.
//

import Foundation

enum UserMembershipLevel: Int {
    
    /// 普通
    case normal     = 1
    /// 青铜
    case copper     = 10
    /// 白银
    case silver     = 20
    /// 黄金
    case gold       = 30
    /// 铂金
    case platinum   = 40
    /// 钻石
    case diamond    = 50
    
    init?(string: String?) {
        if let raw = Int(string ?? ""), let value = Self.init(rawValue: raw) {
            self = value
        } else {
            return nil
        }
    }
}

extension UserMembershipLevel {
    
    private var caseIndex: Int {
        switch self {
        case .normal:   return 0
        case .copper:   return 1
        case .silver:   return 2
        case .gold:     return 3
        case .platinum: return 4
        case .diamond:  return 5
        }
    }
    
    var iconImageName: String {
        return "ic_user_level\(caseIndex)"
    }
    
}
