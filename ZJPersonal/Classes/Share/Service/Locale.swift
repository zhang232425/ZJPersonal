//
//  Locale.swift
//  ZJPersonal
//
//  Created by Jercan on 2023/11/30.
//

import ZJLocalizable

enum Locale: String {
    
    case requestTimeout
    case requestFailed
    case requestFailedPleaseRetry
    
    case main_item_rm
    case main_item_performance
    case main_item_chat
    case main_item_setting
    case main_welcome_title
    case main_welcome_desc
    case main_unlogin_btn_title
    case main_coupon_unused
    case main_go_btn_title
    case main_coupon_title
    case main_invite_title
    case chat_toplevel_faq_prefix
    case chat_phone_call_title
    case chat_phone_call_desc
    case download_telegram
    case generating_certificate

}

extension Locale: ZJLocalizable {
    
    var key: String { rawValue }
    
    var table: String { "Locale" }
    
    var bundle: Bundle { .framework_ZJPersonal }
    
}
