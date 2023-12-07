//
//  API.swift
//  ZJPersonal
//
//  Created by Jercan on 2023/11/30.
//

import Foundation
import ZJRequest
import ZJCommonDefines
import Moya
import ZJDevice

typealias RootModel<T> = ZJRequestResult<T>

typealias AnyRootModel = ZJRequestResult<Any>

enum API {
    
    enum Main {
        
        /// 邀请好友的优惠券描述
        case inviteCouponNotice
        
        /// 用户未读消息数
        case unreadMessageCount
        
        /// 用户未使用的优惠券数
        case unUsedCouponCount
        
        /// 查询用户IM信息
        case userImInfo
        
    }
    
    enum Setting {
        
        /// App升级信息
        case appUpdateInfo
        
        /// 退出登录
        case logout
        
    }
    
}

extension API.Main: ZJRequestTargetType {
    
    var baseURL: URL { URL(string: ZJUrl.server + "/api/app")! }
    
    var path: String {
        switch self {
        case .inviteCouponNotice:
            return "/user/center/inviteCouponInfo"
        case .unreadMessageCount:
            return "/news/unread/cnt"
        case .unUsedCouponCount:
            return "/user/getCouponNewNum"
        case .userImInfo:
            return "/crm/im/user/imInfo"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .inviteCouponNotice:
            return .get
        case .unreadMessageCount:
            return .get
        case .unUsedCouponCount:
            return .get
        case .userImInfo:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .inviteCouponNotice:
            return .requestPlain
        case .unreadMessageCount:
            return .requestPlain
        case .unUsedCouponCount:
            return .requestPlain
        case .userImInfo:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? { nil }
    
    var timeoutInterval: TimeInterval { 30 }
    
    var sampleData: Data { .init() }
    
    var stubBehavior: StubBehavior { .never }
    
}

extension API.Setting: ZJRequestTargetType {
    
    var baseURL: URL { URL(string: ZJUrl.server + "/api/app")! }
    
    var path: String {
        switch self {
        case .appUpdateInfo:
            return "/support/versionDetail/getByApp"
        case .logout:
            return "/user/logout"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .appUpdateInfo:
            return .get
        case .logout:
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case .appUpdateInfo:
            let parameters = ["versionNumber": ZJDevice().appVersion ?? ""]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        case .logout:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? { nil }
    
    var timeoutInterval: TimeInterval { 30 }
    
    var sampleData: Data { .init() }
    
    var stubBehavior: StubBehavior { .never }
    
    
    
}
