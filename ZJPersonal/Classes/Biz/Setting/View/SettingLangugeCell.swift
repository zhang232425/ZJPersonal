//
//  SettingLangugeCell.swift
//  ZJPersonal
//
//  Created by Jercan on 2023/12/6.
//

import UIKit
import RxSwift
import RxCocoa
import ZJLocalizable

class SettingLangugeCell: BaseListCell {
    
    private let disposebag = DisposeBag()
    
    var languageSwitchValueChanged: ((_ isOn: Bool) -> ())?

    private lazy var titleLabel = UILabel().then {
        $0.font = .regular14
        $0.textColor = UIColor(hexString: "333333")
    }
    
    private lazy var englishLabel = UILabel().then {
        $0.font = .regular12
        $0.textColor = UIColor(hexString: "999999")
        $0.highlightedTextColor = UIColor(hexString: "666666")
        $0.textAlignment = .right
        $0.text = "EN"
    }
    
    private lazy var languageSwitch = UISwitch().then {
        // 系统默认 size 是(51, 31), 这里缩小成设计稿中的(37, 22)
        $0.transform = CGAffineTransform(scaleX: 37.0 / 51.0, y: 22.0 / 31.0)
    }
    
    private lazy var bahasaLabel = UILabel().then {
        $0.font = .regular12
        $0.textColor = UIColor(hexString: "999999")
        $0.highlightedTextColor = UIColor(hexString: "666666")
        $0.textAlignment = .right
        $0.text = "ID"
    }
    
    override func setupViews() {
        
        selectionStyle = .none
        
        titleLabel.add(to: contentView).snp.makeConstraints {
            $0.left.equalToSuperview().inset(16.auto)
            $0.centerY.equalToSuperview()
        }
        
        let languageStackView = UIStackView().then {
            $0.spacing = 0.0
            $0.axis = .horizontal
            $0.alignment = .center
            $0.distribution = .fill
        }
        
        languageStackView.add(to: contentView).snp.makeConstraints {
            $0.right.equalToSuperview().inset(16.auto)
            $0.centerY.equalToSuperview()
        }
        
        languageStackView.addArrangedSubview(englishLabel)
        languageStackView.addArrangedSubview(languageSwitch)
        languageStackView.addArrangedSubview(bahasaLabel)
        
        languageSwitch.rx.controlEvent(.valueChanged)
            .withLatestFrom(languageSwitch.rx.value)
            .subscribe(onNext: { [weak self] isOn in
                self?.englishLabel.isHighlighted = !isOn
                self?.bahasaLabel.isHighlighted = isOn
                self?.languageSwitchValueChanged?(isOn)
            }).disposed(by: disposebag)
        
    }

}

extension SettingLangugeCell {
    
    func setRowInfo(_ row: ZJPersonalSettingVC.Row) {
        
        titleLabel.text = row.title
        switch row {
        case .language(let language):
            let isEnglish = language == ZJLocalizedCode.en
            languageSwitch.isOn = !isEnglish
            englishLabel.isHighlighted = !languageSwitch.isOn
            bahasaLabel.isHighlighted = languageSwitch.isOn
        default:
            break
        }
        
    }
    
}
