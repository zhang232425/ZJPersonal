//
//  ZJPersonalCouponsVM.swift
//  ZJPersonal
//
//  Created by Jercan on 2023/12/7.
//

import Foundation
import Action
import RxSwift
import RxCocoa
import RxDataSources

final class ZJPersonalCouponsVM {
    
    enum SectionItem {
        case item(CouponModel)
        case empty
        case noMoreData
    }
    
    enum ActionType {
        case reload
        case loadMore
    }
    
    private(set) lazy var fetchAction: Action<(), Bool> = .init { [weak self] in
        self?.fetchCouponList(type: .reload) ?? .just(false)
    }
    
    private(set) lazy var reloadAction: Action<(), Bool> = .init { [weak self] in
        self?.fetchCouponList(type: .reload) ?? .just(false)
    }
    
    private(set) lazy var loadMoreAction: Action<(), Bool> = .init { [weak self] in
        self?.fetchCouponList(type: .loadMore) ?? .just(false)
    }
    
    private let status: CouponModel.Status
    
    private var page: Int?
    
    let datas = BehaviorRelay(value: [SectionModel<String, SectionItem>]())
    
    init(status: CouponModel.Status) {
        self.status = status
    }
    
}


extension ZJPersonalCouponsVM {
    
    func fetchCouponList(type: ActionType) -> Observable<Bool> {
    
        switch type {
        case .reload:
            page = nil
        case .loadMore:
            if page == nil {
                return .just(false)
            }
        }
        return Request.Coupon.getCouponList(status: status.rawValue, nextPage: page).map {
            self.buildSections(model: $0, type: type)
        }
    }
    
    func buildSections(model: CouponWrapperModel, type: ActionType) -> Bool {
        
        page = model.nextPage
        
        let hasNext = model.nextPage == nil ? false : true
        
        switch type {
            
        case .reload:
            
            datas.accept([])
            
            if model.content.isEmpty {
                datas.accept([.init(model: "", items: [.empty])])
                return hasNext
            }
            
            buildSections(contents: model.content, hasNext: hasNext)
            
        case .loadMore:
            
            buildSections(contents: model.content, hasNext: hasNext)
            
        }
        
        return hasNext
        
    }
    
    func buildSections(contents: [CouponModel], hasNext: Bool) {
        
        var newList = datas.value.first?.items ?? []
        
        let items = contents.map {
            SectionItem.item($0)
        }
        
        if !items.isEmpty {
            newList.append(contentsOf: items)
        }
        
        if !hasNext {
//            newList.append(.noMoreData)
        }
        
        datas.accept([.init(model: "", items: newList)])
        
    }
    
    
}
