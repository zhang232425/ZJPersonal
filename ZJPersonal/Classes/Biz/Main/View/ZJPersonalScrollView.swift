//
//  ZJPersonalScrollView.swift
//  ZJPersonal
//
//  Created by Jercan on 2023/12/1.
//

import UIKit

class ZJPersonalScrollView: UIScrollView {
    
    private(set) lazy var stackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 0
        $0.distribution = .fill
        $0.alignment = .fill
        $0.backgroundColor = .white
    }
    
    private(set) lazy var loginOutView = ZJPersonalLoginOutView()
    
    private(set) lazy var loginOnView = ZJPersonalLoginOnView()
    
    private(set) lazy var menuView = ZJPersonalMenuView()
    
    private(set) lazy var sectionsView = ZJPersonalSectionsView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

private extension ZJPersonalScrollView {
    
    func setupViews() {

        alwaysBounceVertical = true
        
        stackView.add(to: self).snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
        }
        
        stackView.addArrangedSubview(menuView)
        
        stackView.addArrangedSubview(sectionsView)
        
    }
    
}

extension ZJPersonalScrollView {
    
    func updateUI(_ login: Bool) {
        
        if login {
            
            [loginOutView, loginOnView].forEach {
                stackView.removeArrangedSubview($0)
                $0.removeFromSuperview()
            }
        
            loginOnView = .init()
            stackView.insertArrangedSubview(loginOnView, at: 0)
            
        } else {
            
            [loginOutView, loginOnView].forEach {
                stackView.removeArrangedSubview($0)
                $0.removeFromSuperview()
            }
            
            loginOutView = .init()
            stackView.insertArrangedSubview(loginOutView, at: 0)
            
        }
        
    }
    
}
