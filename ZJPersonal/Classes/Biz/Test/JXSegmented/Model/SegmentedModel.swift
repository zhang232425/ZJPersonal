//
//  SegmentedVC.swift
//  ZJPersonal
//
//  Created by Jercan on 2023/12/14.
//

import Foundation

enum SegmentedRow: CaseIterable {
    
    case indicator
    case cellCustom
    case special
    
    var text: String {
        switch self {
        case .indicator:
            return "指示器样式"
        case .cellCustom:
            return "Cell样式"
        case .special:
            return "特殊效果"
        }
    }
    
    var vc: UIViewController {
        switch self {
        case .indicator:
            return IndicatorCustomizeVC(title: text)
        case .cellCustom:
            return CellCustomizeVC(title: text)
        case .special:
            return SpecialCustomizeVC(title: text)
        }
    }
    
}

