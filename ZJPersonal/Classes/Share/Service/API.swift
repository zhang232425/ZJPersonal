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

typealias RootModel<T> = ZJRequestResult<T>

typealias AnyRootModel = ZJRequestResult<Any>

enum API {
    
    /// 邀请好友的优惠券描述
    case inviteCouponNotice
    
}

extension API: ZJRequestTargetType {
    
    var baseURL: URL { URL(string: ZJUrl.server + "/api/app")! }
    
    var path: String {
        switch self {
        case .inviteCouponNotice:
            return "/user/center/inviteCouponInfo"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .inviteCouponNotice:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .inviteCouponNotice:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? { nil }
    
    var timeoutInterval: TimeInterval { 30 }
    
    var sampleData: Data { .init() }
    
    var stubBehavior: StubBehavior { .never }
}
