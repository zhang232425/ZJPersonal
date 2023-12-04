//
//  ZJFundRoutableTarget.swift
//  ZJRoutableTargets
//
//  Created by Jercan on 2023/9/9.
//

import ZJRouter

public struct ZJFundRoutePath {}

public extension ZJFundRoutePath {
    
    static let fund = ZJRoutePath(value: "as://fund.fund")
    static let test = ZJRoutePath(value: "as://fund.test")
    
}

public enum ZJFundRoutableTarget {
    
    case fund
    case test
    
}

extension ZJFundRoutableTarget: ZJRoutableTarget {
    
    public var path: ZJRoutePath {
        switch self {
        case .fund:
            return ZJFundRoutePath.fund
        case .test:
            return ZJFundRoutePath.test
        }
    }
    
    public var parameters: [String : Any]? {
        switch self {
        case .fund:
            return nil
        case .test:
            return nil
        }
    }
    
    
    
}
