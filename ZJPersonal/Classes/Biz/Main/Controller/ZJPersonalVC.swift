//
//  ZJPersonalViewController.swift
//  ZJPersonal
//
//  Created by Jercan on 2023/9/5.
//

import UIKit
import RxSwiftExt

class ZJPersonalVC: BaseVC {
    
    private let viewModel = ZJPersonalVM()
    
    private lazy var scrollView = ZJPersonalScrollView()
    
    private lazy var unreadMessageView = ZJUnreadMessageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        bindViewModel()
    }
    
}

private extension ZJPersonalVC {
    
    func setupViews() {
        
        view.backgroundColor = UIColor(hexString: "#F3F3F3")
        navigationItem.rightBarButtonItem = .init(customView: unreadMessageView)
        navigationController?.navigationBar.shadowImage = .init()
        navigationController?.navigationBar.isTranslucent = false
        
        scrollView.add(to: view).snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
    }
    
    func bindViewModel() {
        
        viewModel.isLoginState.subscribeNext(weak: scrollView, ZJPersonalScrollView.updateUI).disposed(by: disposeBag)
        
    }
    
}
