//
//  UITabBarItem+Badge.swift
//  ZJPersonal
//
//  Created by Jercan on 2023/12/5.
//

import Foundation
import RxSwift
import RxCocoa
import ESTabBarController_swift

extension UITabBarItem {
    
    func addCustomBadge(color: UIColor = UIColor(hexString: "FF0101")) {
        (self as? ESTabBarItem)?.badgeColor = color
        (self as? ESTabBarItem)?.badgeValue = ""
    }
    
    func removeCustomBadge() {
        (self as? ESTabBarItem)?.badgeColor = nil
        (self as? ESTabBarItem)?.badgeValue = nil
    }
    
}

extension Reactive where Base: UITabBarItem {
    
    var showCustomBadge: Binder<Bool> {
        return Binder(self.base) { item, show in
            if show {
                item.addCustomBadge()
            } else {
                item.removeCustomBadge()
            }
        }
    }
    
}
