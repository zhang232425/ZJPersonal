//
//  TestVM.swift
//  ZJPersonal
//
//  Created by Jercan on 2023/12/13.
//

import Foundation
import RxCocoa
import RxDataSources

struct TestVM {
    
    let datas = BehaviorRelay(value: [SectionModel(model: "", items: TestRow.allCases)])
    
}
