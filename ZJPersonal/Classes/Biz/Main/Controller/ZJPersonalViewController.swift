//
//  ZJPersonalViewController.swift
//  ZJPersonal
//
//  Created by Jercan on 2023/9/5.
//

import UIKit

class ZJPersonalViewController: BaseViewController {
    
    private lazy var label = UILabel().then {
        $0.text = "个人主页"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

}

private extension ZJPersonalViewController {
    
    func setupViews() {
        
        label.add(to: view).snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
    }
    
}
