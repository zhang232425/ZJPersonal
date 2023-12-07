//
//  ZJPersonalSettingVC.swift
//  ZJPersonal
//
//  Created by Jercan on 2023/12/6.
//

import UIKit
import ZJLocalizable
import RxDataSources
import RxSwift
import RxCocoa
import ZJLoginManager
import ZJDevice
import ZJCommonDefines
import ZJHUD

class ZJPersonalSettingVC: BaseVC {

    enum Row {
        case userProfile
        case language(ZJLocalizedCode)
        case appVersion(String, Bool)
        case cache(Int)
        case logout
        case cancelAccount
        
        var title: String {
            switch self {
            case .userProfile:
                return Locale.userInfoTitle.localized
            case .language:
                return Locale.languageSelection.localized
            case .appVersion:
                return Locale.appVersionTitle.localized
            case .cache:
                return Locale.clearCache.localized
            case .logout:
                return Locale.signOut.localized
            case .cancelAccount:
                return Locale.accountDeletion.localized
            }
        }
        
    }

//    private let items = BehaviorRelay(value: [Row]())
//    private let items = BehaviorRelay(value: [SectionModel<String, Row>]())
//    private let items = BehaviorRelay<[SectionModel<Void, Row>]>(value: .init())
    
    private var viewModel = ZJPersonalSettingVM()
    
    private let datas = BehaviorRelay<[SectionModel<Void, Row>]>(value: .init())
    private var dataSource: RxTableViewSectionedReloadDataSource<SectionModel<Void, Row>>!
    
    private lazy var tableView = UITableView(frame: .zero, style: .grouped).then {
        $0.backgroundColor = .clear
        $0.showsVerticalScrollIndicator = false
        $0.separatorColor = UIColor(hexString: "E6E6E6")
        $0.separatorInset = .init(top: 0, left: 20.auto, bottom: 0, right: 0)
        $0.registerCell(SettingCommonCell.self)
        $0.registerCell(SettingLangugeCell.self)
        $0.registerCell(SettingAppVersionCell.self)
        $0.registerCell(SettingLogoutCell.self)
        $0.rx.setDelegate(self).disposed(by: disposeBag)
        $0.sectionFooterHeight = .leastNormalMagnitude
        $0.tableFooterView = .init()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        bindData()
        bindAction()
    }
    
}

private extension ZJPersonalSettingVC {
    
    func setupViews() {
        
        navigationItem.title = Locale.settingTitle.localized
        view.backgroundColor = UIColor(hexString: "F3F3F3")
        
        tableView.add(to: view).snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
    }
    
    func bindData() {
        
        /**
        let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<Void, Row>>(configureCell: { (_, tableView, indexPath, item) in
            
            switch item {
                
            case .userProfile:
                
                let cell: SettingCommonCell = tableView.dequeueReuseableCell(forIndexPath: indexPath)
                return cell
                
            case .language:
                
                let cell: SettingCommonCell = tableView.dequeueReuseableCell(forIndexPath: indexPath)
                return cell
                
            case .appVersion:
                
                let cell: SettingCommonCell = tableView.dequeueReuseableCell(forIndexPath: indexPath)
                return cell
                
            case .cache:
                
                let cell: SettingCommonCell = tableView.dequeueReuseableCell(forIndexPath: indexPath)
                return cell
                
            case .logout:
                
                let cell: SettingCommonCell = tableView.dequeueReuseableCell(forIndexPath: indexPath)
                return cell
                
            case .cancelAccount:
                
                let cell: SettingCommonCell = tableView.dequeueReuseableCell(forIndexPath: indexPath)
                return cell
                
            }
            
        })
         */
        
        dataSource = .init(configureCell: { (_, tableView, indexPath, item) in
            
            switch item {
                
            case .userProfile:
                
                let cell: SettingCommonCell = tableView.dequeueReuseableCell(forIndexPath: indexPath)
                cell.setRowInfo(item)
                return cell
                
            case .language:
                
                let cell: SettingLangugeCell = tableView.dequeueReuseableCell(forIndexPath: indexPath)
                cell.setRowInfo(item)
                return cell
                
            case .appVersion:
                
                let cell: SettingAppVersionCell = tableView.dequeueReuseableCell(forIndexPath: indexPath)
                cell.setRowInfo(item)
                return cell
                
            case .cache:
                
                let cell: SettingCommonCell = tableView.dequeueReuseableCell(forIndexPath: indexPath)
                cell.setRowInfo(item)
                return cell
                
            case .logout:
                
                let cell: SettingLogoutCell = tableView.dequeueReuseableCell(forIndexPath: indexPath)
                cell.setRowInfo(item)
                return cell
                
            case .cancelAccount:
                
                let cell: SettingCommonCell = tableView.dequeueReuseableCell(forIndexPath: indexPath)
                cell.setRowInfo(item)
                return cell
                
            }
            
        })
        
        datas.bind(to: tableView.rx.items(dataSource: dataSource)).disposed(by: disposeBag)
        
        reloadData()
        
        SandboxCacheUtil.calculateCacheSize { [weak self] size in
            self?.refreshItem(row: .cache(size))
        }
        
    }
    
    func bindAction() {
        
        viewModel.appVersionAction.elements
            .subscribeNext(weak: self, ZJPersonalSettingVC.refreshAppVersion)
            .disposed(by: disposeBag)
        
        viewModel.logoutAction.elements
            .subscribeNext(weak: self, ZJPersonalSettingVC.logout)
            .disposed(by: disposeBag)
        
        tableView.rx.itemSelected.subscribe(onNext: { [weak self] in
            self?.tableView.deselectRow(at: $0, animated: true)
        }).disposed(by: disposeBag)
        
//        tableView.rx.modelSelected(Row.self)
//            .subscribe(weak: self, onNext:  ZJPersonalSettingVC.handleClick)
//            .disposed(by: disposeBag)
        
        tableView.rx.modelSelected(Row.self)
            .subscribeNext(weak: self, ZJPersonalSettingVC.handleClick)
            .disposed(by: disposeBag)
        
        viewModel.appVersionAction.execute()
        
    }
    
    func reloadData() {
        
        if ZJLoginManager.shared.isLogin {
            
            datas.accept([SectionModel(model: (), items: [.userProfile]),
                          SectionModel(model: (), items: [.language(ZJLocalizer.currentLanguage),
                                                          .appVersion(ZJDevice().appVersion ?? "", true),
                                                          .cache(0),
                                                          .cancelAccount]),
                          SectionModel(model: (), items: [.logout])
                         ])
            
        } else {
            
            datas.accept([.init(model: (), items: [.userProfile]),
                          .init(model: (), items: [.language(ZJLocalizer.currentLanguage),
                                                   .appVersion(ZJDevice().appVersion ?? "", true),
                                                   .cache(0)])
                        ])
            
        }
        
    }
    
}

private extension ZJPersonalSettingVC {
    
    func refreshItem(row: Row) {
        
        var sectionDatas = datas.value
        
        for (i, sec) in sectionDatas.enumerated() {
            var section = sec
            for (j, r) in section.items.enumerated() {
                if case .language = row, case .language = r {
                    section.items[j] = row
                    sectionDatas[i] = section
                    datas.accept(sectionDatas)
                    return
                }
                if case .cache = row, case .cache = r {
                    section.items[j] = row
                    sectionDatas[i] = section
                    datas.accept(sectionDatas)
                    return
                }
                if case .appVersion = row, case .appVersion = r {
                    section.items[j] = row
                    sectionDatas[i] = section
                    datas.accept(sectionDatas)
                    return
                }
            }
        }
        
    }
    
    func refreshAppVersion(_ info: UpdateInfoModel) {
        
        let hasNew = !info.isLatestVersion
        UserDefaults.VersionInfo.hasNew = hasNew
        UserDefaults.VersionInfo.updateLink = info.downloadLink ?? ""
        self.refreshItem(row: .appVersion(ZJDevice().appVersion ?? "", hasNew))
        
    }
    
    func handleClick(_ row: Row) {
        
        switch row {
        case .userProfile:
            print("个人资料")
        case .appVersion:
            print("版本更新")
        case .cache:
            print("清空缓存")
        case .logout:
            requestLogout()
        case .cancelAccount:
            print("注销账号")
        default:
            break
        }
        
    }
    
    func requestLogout() {
        
        /**
         API(PersonalAPI.logout)
             .showLoading(in: view)
             .showToast(.onRequestError)
             .requestObject(success: { (root: AnyRootModel) in
                 if root.success {
                     ASLoginManager.shared.logout()
                     NotificationCenter.default.post(name: ASNotification.didLogout, object: nil)
                     HUD.showToast(StringAsset.logoutSuccess.localized)
                 } else {
                     HUD.showToast(root.validated.errMsg)
                 }
             })
         */
        
        viewModel.logoutAction.execute()
        
    }
    
    func logout(_ : Bool) {
        
        ZJLoginManager.shared.logout()
        NotificationCenter.default.post(name: ZJNotification.didLogout, object: nil)
        ZJHUD.noticeOnlyText(Locale.logoutSuccess.localized)
        
    }
    
}

extension ZJPersonalSettingVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 48.auto
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return .leastNormalMagnitude
        }
    
        return 12.auto
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
}
