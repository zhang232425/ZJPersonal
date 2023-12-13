//
//  CouponModel.swift
//  ZJPersonal
//
//  Created by Jercan on 2023/12/7.
//

import HandyJSON

struct CouponWrapperModel: HandyJSON {
    
    var nextPage: Int?
    
    var content = [CouponModel]()
}

class CouponModel: HandyJSON {
    
    enum Status: Int, HandyJSONEnum {
        case available = 1
        case expired = 2
        case used = 3
    }
    
    enum _Type: Int, HandyJSONEnum {
        case cash = 1 // 旧现金券
        case interest = 2 // 加息
        case experience = 3 // 体验金
        case cash2 = 4 // 新现金券
        case privilege = 10 // 预约券
    }
    
    enum Package: Int, HandyJSONEnum {
        case birthday       = 11 // 生日礼包
        case newLender      = 12 // 新手礼包
        case reachStandard  = 13 // 达标礼包
    }
    
    
    var id = 0
    
    var minPeriod = ""
    var maxPeriod = ""
    var minAmount = ""
    var maxAmount = ""
    
    var status: Status?
    var type: _Type?
    var sendType: Package?
    
    var title: String?
    var subname: String?
    var desc: String?
    
    var deadline = 0
    var total = 0
    
    required init() {}
    
}

extension CouponModel.Status {
    
    var title: String {
        switch self {
        case .available:
            return Locale.available.localized
        case .used:
            return Locale.used.localized
        case .expired:
            return Locale.expired.localized
        }
    }
    
}

extension CouponModel {
    
    var iconImageName: String {
        
        var imageName: String
        
        switch type {
        case .cash, .cash2:
            imageName = "ic_coupon_cash"
        case .interest:
            imageName = "ic_coupon_interest"
        case .experience:
            imageName = "ic_coupon_experience"
        case .privilege:
            imageName = "ic_coupon_privilege"
        case .none:
            imageName = ""
        }
        if self.status != .available {
            imageName.append("_gray")
        }
        return imageName
    }
    
}

extension CouponModel.Package {
    
    var title: String {
        switch self {
        case .birthday:
            return Locale.couponBirthdayGift.localized
        case .newLender:
            return Locale.couponNewLenderGift.localized
        case .reachStandard:
            return Locale.couponUpgradeGift.localized
        }
    }
    
    var iconImgName: String {
        switch self {
        case .birthday:
            return "ic_coupon_gift_birthday"
        case .newLender:
            return "ic_coupon_gift_newlender"
        case .reachStandard:
            return "ic_coupon_gift_upgrade"
        }
    }
    
}
