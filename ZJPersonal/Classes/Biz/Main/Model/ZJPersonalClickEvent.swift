//
//  ZJPersonalClickEvent.swift
//  ZJPersonal
//
//  Created by Jercan on 2023/12/4.
//

import Foundation

enum ZJPersonalClickEvent {

    /// 登录注册
    case loginOrRegister
    
    /// 消息icon
    case messageIcon
    
    /// 用户资料
    case userProfile
    
    /// 会员web
    case membershipIntro
    
    /// 邀请好友
    case inviteFriends
    
    /// 优惠券列表
    case couponList
    
    /// 资助证书
    case sponsorCertificate
    
}

extension ZJPersonalClickEvent: CommonResponderEvent {}
