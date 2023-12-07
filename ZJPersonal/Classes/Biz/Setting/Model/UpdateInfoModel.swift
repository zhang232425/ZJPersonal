//
//  UpdateInfoModel.swift
//  ZJPersonal
//
//  Created by Jercan on 2023/12/6.
//

import Foundation
import HandyJSON

struct UpdateInfoModel: HandyJSON {
    
    enum Device: Int, HandyJSONEnum {
        case iOS = 2
        case android = 4
    }
    
    enum Update: Int, HandyJSONEnum {
        case none = 0
        case optional = 1
        case force = 2
    }
    
    enum Language: Int, HandyJSONEnum {
        case indonesia = 123
        case english = 102
    }
    
    
    var deviceType: Device?
    
    var downloadLink: String?
    
    var versionNumber: String?
    
    var versionTitle: String?
    
    var versionContent: String?
    
    var updateType: Update?
    
    var languageId: Language?
    
    var isLatestVersion = true
    
    var minVersionNumber: String?
    
}
