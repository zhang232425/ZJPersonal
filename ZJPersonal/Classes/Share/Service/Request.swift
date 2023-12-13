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
import ZJLoginManager

struct Request {}

extension Request {
    
    enum Main {}
    
    enum Setting {}
    
    enum Coupon {}
    
}

extension Request.Main {
    
    static func inviteCouponNotice() -> Single<String> {
        
        API.Main.inviteCouponNotice.rx.request()
            .mapObject(RootModel<[String: Any]>.self)
            .map { ($0.data?["couponDes"] as? String) ?? "" }
        
    }
    
    static func inviteCouponNotice_() -> Single<String?> {
        
        API.Main.inviteCouponNotice.rx.request()
            .mapObject(ZJRequestResult<[String: Any]>.self)
            .map { $0.data?["couponDes"] as? String }
        
    }
    
    static func inviteCouponNotice__() -> Observable<String?> {
        
        API.Main.inviteCouponNotice.rx.request()
            .mapObject(ZJRequestResult<[String: Any]>.self)
            .map { $0.data?["couponDes"] as? String }
            .asObservable()
        
    }
    
    static func inviteCouponNotice___() -> Observable<String> {
        
        API.Main.inviteCouponNotice.rx.request()
            .mapObject(ZJRequestResult<[String: Any]>.self)
            .map { ($0.data?["couponDes"] as? String) ?? "" }
            .asObservable()
        
    }

    static func fetchUserProfile() -> Single<ZJUserProfile> {
        
        .create { single in
            ZJLoginManager.shared.fetchUserProfile(success: {
                if let m = $0 {
                    single(.success(m))
                } else {
                    let domain = "ResponseErrorDomain"
                    let userInfo = [NSLocalizedDescriptionKey: "profile is null"]
                    let err = NSError(domain: domain, code: -1, userInfo: userInfo)
                    single(.failure(err))
                }
            }, failure: {
                single(.failure($0))
            })
            return Disposables.create()
        }
        
    }
    
    static func getUnreadMessageCount() -> Single<Int> {
        
        API.Main.unreadMessageCount.rx.request()
            .ensureResponseStatus()
            .mapObject(ZJRequestResult<Int>.self)
            .map { $0.data ?? 0 }
        
    }

    static func getUnreadCouponCount() -> Single<Int> {
        
        API.Main.unUsedCouponCount.rx.request()
            .ensureResponseStatus()
            .mapObject(ZJRequestResult<[String: Int]>.self)
            .map { $0.data?["newCouponNum"] ?? 0 }
        
    }

    static func hasUnReadChatMessage() -> Single<Bool> {
        
        API.Main.userImInfo.rx.request()
            .ensureResponseStatus()
            .mapObject(RootModel<[String: Any]>.self)
            .map { ($0.data?["hasUnreadMsg"] as? Bool) ?? false }
        
    }
    
    
}

extension Request.Setting {
    
    static func getAppUpdateInfo() -> Single<UpdateInfoModel> {
        
        API.Setting.appUpdateInfo.rx.request()
            .ensureResponseStatus()
            .mapObject(ZJRequestResult<UpdateInfoModel>.self)
            .map { $0.data ?? .init() }
        
    }
    
    static func logout() -> Single<Bool> {
        
        API.Setting.logout.rx.request()
            .ensureResponseStatus()
            .mapObject(RootModel<[String: Any]>.self)
            .map { $0.success }
        
    }
    
}

extension Request.Coupon {
    
    static func getCouponList(status: Int, nextPage: Int?) -> Observable<CouponWrapperModel> {
        
        API.Coupon.getCouponList(status: status, nextPage: nextPage).rx.request()
            .ensureResponseStatus()
            .mapObject(ZJRequestResult<CouponWrapperModel>.self)
            .map { $0.data ?? .init() }
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
