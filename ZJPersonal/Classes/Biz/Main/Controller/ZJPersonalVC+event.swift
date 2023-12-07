//
//  ZJPersonalVC+event.swift
//  ZJPersonal
//
//  Created by Jercan on 2023/12/4.
//

import Foundation
import ZJBase
import ZJRoutableTargets
import ZJLoginManager

extension ZJPersonalVC {
    
    override func handleEvent(name: String, userInfo: [AnyHashable : Any]) {
        
        switch name {
            
        case ZJPersonalClickEvent.loginOrRegister.name:
            present(vc: ZJLoginRoutableTarget.login.viewController)
            
        case ZJPersonalClickEvent.messageIcon.name:
            if ZJLoginManager.shared.isLogin {
                push(to: ZJPersonalMessageVC())
            } else {
                present(vc: ZJLoginRoutableTarget.login.viewController)
            }
        
        case ZJPersonalClickEvent.inviteFriends.name:
            print("inviteFriends")
            
        case ZJPersonalClickEvent.couponList.name:
            print("couponList")
            
        case ZJPersonalClickEvent.userProfile.name:
            print("userProfile")
            
        case ZJPersonalSection.settings.name:
            let vc = ZJPersonalSettingVC()
            push(to: vc)
            
        default:
            break
        }
        
    }
    
}

private extension ZJPersonalVC {

    func push(to vc: UIViewController?) {
        if let vc = vc {
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func present(vc: UIViewController?) {
        if let vc = vc {
            let topVC = UIApplication.shared.topViewController
            let navVC = ZJNavigationController(rootViewController: vc)
            topVC?.present(navVC, animated: true)
        }
    }
    
}
