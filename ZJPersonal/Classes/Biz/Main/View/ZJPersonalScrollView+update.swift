//
//  ZJPersonalScrollView+update.swift
//  ZJPersonal
//
//  Created by Jercan on 2023/12/4.
//

import Foundation

extension ZJPersonalScrollView {
    
    func updateSections(sections: [ZJPersonalSection]) {
        
        sectionsView.updateSections(sections)
        
    }
    
    func updateCouponNotice(_ text: String) {
        
        menuView.updateInviteCouponNotice(text)
        
    }
    
}
