//
//  ViewController.swift
//  ZJPersonal
//
//  Created by 51930184@qq.com on 09/05/2023.
//  Copyright (c) 2023 51930184@qq.com. All rights reserved.
//

import UIKit
import ZJRoutableTargets

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    
    @IBAction func homeClick() {
        
        if let vc = ZJPersonalRoutableTarget.personal.viewController {
            present(vc, animated: true)
        }
        
    }
    
    @IBAction func testClick() {
        
        if let vc = ZJPersonalRoutableTarget.test.viewController {
            present(vc, animated: true)
        }
        
    }
    

}

