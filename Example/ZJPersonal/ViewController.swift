//
//  ViewController.swift
//  ZJPersonal
//
//  Created by 51930184@qq.com on 09/05/2023.
//  Copyright (c) 2023 51930184@qq.com. All rights reserved.
//

import UIKit
import ZJBase
import ZJRoutableTargets

class ViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var controllers = [UIViewController]()
        
        if let vc = ZJPersonalRoutableTarget.personal.viewController {
            
            let personalVC = ZJNavigationController(rootViewController: vc)
            personalVC.tabBarItem = .init(title: "Personal", image: UIImage(color: .blue, size: .init(width: 10, height: 10)), tag: 0)
            controllers.append(personalVC)
            
        }
        
        if let vc = ZJLoginRoutableTarget.login.viewController {
            
            let loginVC = ZJNavigationController(rootViewController: vc)
            loginVC.tabBarItem = .init(title: "Login", image: UIImage(color: .blue, size: .init(width: 10, height: 10)), tag: 0)
            controllers.append(loginVC)
            
        }
        
        viewControllers = controllers
        
    }


}

