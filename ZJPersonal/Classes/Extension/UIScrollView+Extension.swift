//
//  UIScrollView+Extension.swift
//  ZJPersonal
//
//  Created by Jercan on 2023/12/4.
//

import Foundation
import RxSwift
import ZJRefresh

extension Reactive where Base: UIScrollView {
    
    var addRefreshHeader: Observable<()> {
        
        return .create { [weak base] (observer) -> Disposable in
            
            if let base = base {
                base.addPullToRefresh {
                    observer.onNext(())
                }
            } else {
                observer.onCompleted()
            }
            
            return Disposables.create {
                base?.endPullToRefresh()
            }
            
        }
        
    }
    
    var addLoadingFooter: Observable<()> {
        
        return .create { [weak base] (observer) -> Disposable in
            
            if let base = base {
                base.addInfinityScroll {
                    observer.onNext(())
                }
            } else {
                observer.onCompleted()
            }
            
            return Disposables.create {
                base?.endInfinityScroll()
            }
            
        }
        
    }
    
    var endHeaderRefresh: Binder<()> {
        
        return Binder(base) { control, _ in
            control.endPullToRefresh()
        }
        
    }
    
    var endFooterLoading: Binder<Bool> {
        
        return Binder(base) { control, hasMore in
            control.endInfinityScroll()
            if hasMore {
                control.resetNoMoreData()
            } else {
                control.noticeNoMoreData()
            }
        }
        
    }
    
}
