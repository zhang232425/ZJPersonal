//
//  ZJPersonalScrollView+update.swift
//  ZJPersonal
//
//  Created by Jercan on 2023/12/4.
//

import Foundation
import ZJLoginManager

extension ZJPersonalScrollView {
    
    func updateSections(sections: [ZJPersonalSection]) {
        
        sectionsView.updateSections(sections)
        
    }
    
    func updateCouponNotice(_ text: String) {
        
        menuView.updateInviteCouponNotice(text)
        
    }
    
    func updateProfile(_ profile: ZJUserProfile) {
        
        loginOnView.updateProfile(profile)
        
    }
    
    func updateUnusedCoupon(count: Int) {
        
        menuView.updateUnusedCoupon(count: count)
    }
    
    func updateHasUnreadChatMsg(_ has: Bool) {
        
//        sectionsView.updateHasUnreadChatMsg(has)
        
    }
    
}
