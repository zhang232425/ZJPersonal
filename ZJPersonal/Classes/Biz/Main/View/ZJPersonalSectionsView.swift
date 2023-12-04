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
    
    func updateSections(_ sections: [ZJPersonalSection]) {
        
        stackView.arrangedSubviews.forEach {
            stackView.removeArrangedSubview($0)
            $0.removeFromSuperview()
        }
        
        sections.forEach {
            let view = ZJPersonalSectionItemView(section: $0)
            view.label.text = $0.title
            view.iconImageView.image = .named($0.imageName)
            
            stackView.addArrangedSubview(view)
            view.snp.makeConstraints {
                $0.left.right.equalToSuperview()
                $0.height.equalTo(50.auto)
            }
        }
        
    }
    
}
