//
//  SegmentedVM.swift
//  ZJPersonal
//
//  Created by Jercan on 2023/12/14.
//

import Foundation
import RxCocoa
import RxDataSources

struct SegmentedVM {
    
    var datas = BehaviorRelay(value: [SectionModel(model: "", items: SegmentedRow.allCases)])
    
}

