//
//  ZJPersonalSectionsContainerView.swift
//  ZJPersonal
//
//  Created by Jercan on 2023/12/1.
//

import UIKit

class ZJPersonalSectionsView: BaseView {

    private lazy var stackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 0
        $0.distribution = .fill
        $0.alignment = .fill
    }

    override func setupViews() {
        
        stackView.add(to: self).snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
    }

}

extension ZJPersonalSectionsView {
    
    func setSections(_ sections: [ZJPersonalSection]) {
        
        
        
    }
    
}
