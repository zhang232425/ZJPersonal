//
//  ZJPersonalModule.swift
//  Action
//
//  Created by Jercan on 2023/9/5.
//

import ZJRouter
import ZJRoutableTargets
import ZJBase

public struct ZJPersonalModule: ZJModule {
    
    public init() {}
    
    public func initialize() {
        
        ZJPersonalRoutableTarget.register(path: ZJPersonalRoutePath.personal) { _ in
            return ZJPersonalVC()
        }
        
        ZJPersonalRoutableTarget.register(path: ZJPersonalRoutePath.test) { _ in
            return ZJTestVC()
        }
        
    }
    
}


