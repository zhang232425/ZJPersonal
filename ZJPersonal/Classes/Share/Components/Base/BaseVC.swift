//
//  BaseViewController.swift
//  ZJPersonal
//
//  Created by Jercan on 2023/11/30.
//

import UIKit
import ZJBase
import RxSwift
import Then
import Action
import ZJHUD
import ZJExtension

class BaseVC: ZJViewController {
    
    let disposeBag = DisposeBag()
    
    var hud: ZJHUDView?
    
    var hudSuperView: UIView?
    
    private(set) var noSignalView: ZJNoSignalView?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    func doProgress(_ executing: Bool) {
        noSignalView?.removeFromSuperview()
        view.endEditing(true)
        if executing {
            hud?.hide()
            hud = ZJHUDView()
            hudSuperView == nil ? hud?.showProgress(in: view) : hud?.showProgress(in: hudSuperView)
        } else {
            hud?.hide()
        }
    }
    
    func showNoSignalView(_ :()) {
        let errorView = noSignalView ?? ZJNoSignalView()
        errorView.removeFromSuperview()
        errorView.add(to: view).then {
            noSignalView = $0
        }.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    
    func doError(_ error: ActionError) {
        if case .underlyingError(let err) = error {
            ZJHUD.noticeOnlyText(err.localizedDescription)
        }
    }
    
    deinit {
        hud?.hide()
        ZJHUD.hideProgress()
    }
    
}
