//
//  TestModel.swift
//  ZJPersonal
//
//  Created by Jercan on 2023/12/14.
//

import Foundation

enum TestRow: String, CaseIterable {
    
    case JXSegmented
    case JXPagingView
    case POP
    case FP
    
    var vc: UIViewController {
        switch self {
        case .JXSegmented:
            return SegmentedVC(title: self.rawValue)
        case .JXPagingView:
            return JXPagingVC(title: self.rawValue)
        case .POP:
            return POPViewController(title: self.rawValue)
        case .FP:
            return FPViewController(title: self.rawValue)
        }
    }
    
}
