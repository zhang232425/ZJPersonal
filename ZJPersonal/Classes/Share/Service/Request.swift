//
//  Request.swift
//  ZJPersonal
//
//  Created by Jercan on 2023/11/30.
//

import Foundation
import RxSwift
import Moya
import SwiftyJSON
import ZJValidator
import ZJRequest

struct Request {}

extension Request {
    
    enum main {}
    
}

extension Request.main {
    
    static func inviteCouponNotice() -> Single<String> {
        
        API.inviteCouponNotice.rx.request()
            .mapObject(RootModel<[String: Any]>.self)
            .map { ($0.data?["couponDes"] as? String) ?? "" }
        
    }
    
    static func inviteCouponNotice_() -> Single<String?> {
        
        API.inviteCouponNotice.rx.request()
            .mapObject(ZJRequestResult<[String: Any]>.self)
            .map { $0.data?["couponDes"] as? String }
        
    }
    
    static func inviteCouponNotice__() -> Observable<String?> {
        
        API.inviteCouponNotice.rx.request()
            .mapObject(ZJRequestResult<[String: Any]>.self)
            .map { $0.data?["couponDes"] as? String }
            .asObservable()
        
    }
    
    static func inviteCouponNotice___() -> Observable<String> {
        
        API.inviteCouponNotice.rx.request()
            .mapObject(ZJRequestResult<[String: Any]>.self)
            .map { ($0.data?["couponDes"] as? String) ?? "" }
            .asObservable()
        
    }
    
}

enum NetworkError: LocalizedError {
    
    case noNetwork
    
    var errorDescription: String? {
        switch self {
        case .noNetwork:
            return Locale.requestFailedPleaseRetry.localized
        }
    }
    
}

extension PrimitiveSequence where Trait == SingleTrait, Element == Moya.Response {
    
    func ensureResponseStatus() -> Single<JSON> {
        
        return mapSwiftyJSON().flatMap { (json) -> Single<JSON> in
            
            let success = json["success"].boolValue
            let code    = json["errCode"].string
            let message = json["errMsg"].string
            
            let result = ZJResponseCodeValidator.validate(success: success, code: code, msg: message)
            
            guard result.success else {
                
                let userInfo = [NSLocalizedDescriptionKey: json["errCode"].stringValue + ":" + json["errMsg"].stringValue]
                
                throw NSError(domain: "RequestFailureDomain", code: -1, userInfo: userInfo)
                
            }
            
            return .just(json)
            
        }
        
    }
    
}

/**
extension PrimitiveSequence where Trait == SingleTrait, Element == Moya.Response {
    
    func ensureResponseStatus() -> Single<JSON> {
        
        return mapSwiftyJSON().flatMap { (json) -> Single<JSON> in
            
            let result = ZJResponseCodeValidator.validate(success: json["success"].boolValue, code: json["errCode"].string, msg: json["errMsg"].string)
            
            guard result.success else {
                
                var userInfo = [String: Any]()
                
                userInfo[NSLocalizedDescriptionKey] = result.message
                
                userInfo["errorCode"] = result.code
                
                throw NSError(domain: "RequestFailureDomain", code: -1, userInfo: userInfo)
                
            }
            
            return .just(json)
            
        }
        
    }
    
}
*/
