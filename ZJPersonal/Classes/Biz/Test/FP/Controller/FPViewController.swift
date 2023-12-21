//
//  FPViewController.swift
//  ZJPersonal
//
//  Created by Jercan on 2023/12/20.
//

import UIKit
import RxSwift

/** 函数式编程
 https://juejin.cn/post/6984314556851945509
 */

class FPViewController: BaseVC {
    
    private lazy var testBtn = UIButton(type: .system).then {
        $0.setTitle("Test", for: .normal)
    }
    
    init(title: String) {
        super.init(nibName: nil, bundle: nil)
        self.navigationItem.title = title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        bindActions()
    }
    
}

private extension FPViewController {
    
    func setupViews() {
        
        testBtn.add(to: view).snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
    }
    
    func bindActions() {
        
        testBtn.rx.tap.subscribe(onNext: { [weak self] in
            self?.testClick()
        }).disposed(by: disposeBag)
        
    }
    
    func testClick() {
        allSatisfy()
    }
    
}

//// --------------------------------- 高阶函数 ----------------------------------

private extension FPViewController {
    
    /**
     sorted：排序 常用于数组和字典(key/value)的排序
     map：遍历 每一个元素做一次映射操作
     flatMap：遍历 多用于数组的降维度
     compactMap：遍历 多用于处理数组的可选值
     filer：过滤 对数组元素根据规则过滤一次
     reduce：多用途 基础思想是将一个序列转换为一个不同类型的数据，期间通过一个累加器（Accumulator）来持续记录递增状态
     */
    
    /** 闭包的完整格式
     { (parameters) -> return type in // 闭包的参数和返回类型
        statements                    // 闭包体
     }
     */
    
    /// sorted排序函数
    func sorted1() {
        
        let array = [6, 4, 5, 3, 1, 0, 2]
        
        /// 完整的sorted的写法
        let result = array.sorted(by: { (a: Int, b: Int) -> Bool in
            return a < b
        })
        
        /// 如果传入的参数，最后一个是闭包，那么可以把闭包放在（）外面
        let _ = array.sorted() { (a: Int, b: Int) -> Bool in
            return a < b
        }
        
        /// 如果传入的参数只有一个，并且是一个闭包，那么这个（）可以省略
        let _ = array.sorted { (a: Int, b: Int) -> Bool in
            return a < b
        }
        
        /// 闭包体只有一行代码，可以省略return
        let _ = array.sorted { (a: Int, b: Int) -> Bool in
            a < b
        }
        
        /// 闭包可根据上下文推断参数和返回值的类型
        let _ = array.sorted { (a, b) -> Bool in
            a < b
        }
        
        /// 简化闭包的参数名.使用简化参数名，in和之前的描述可以省略
        let _ = array.sorted { $0 < $1 }
        
        
        
    }

    func sorted2() {
    
        // 常用于数组和字典的排序
        /*
        let array = [5, 9, 3, 6, 1, 2, 7, 0]
        let result = array.sorted()
        let result2 = array.sorted(by: >)
        print("result ==== \(result)")
        print("result2 ==== \(result2)")
         */
        
        // 字典操作
        let dict = ["1": "b", "2": "a", "3": "c"]
        /// 字典key的排序
        let dict1 = dict.sorted { (a, b) -> Bool in
            return a.key < b.key
        }
        let dict2 = dict.sorted { $0.value > $1.value }
        print("dict1 ==== \(dict1)")
        print("dict2 ==== \(dict2)")
        
    }
    
    /// map映射函数
    /***
     * 可以对数组中的每一个元素做一次映射操作
     * map函数返回一个新的数组，并且数组的类型不要求和原数组类型一致
     */
    func map1() {
        
        /*
        let array = [1, 2, 3, 4, 5]
        let mapArr = array.map { $0 * 2 }
        print("mapArr ====== \(mapArr)")
        */
        
        /* 获取的数组类型和入参的数组类型无关联
        let array = ["Swift", "Objc", "Flutter"]
        let mapArr = array.map { $0.count }
        print("mapArr ====== \(mapArr)")
        */
        
        // 返回值中允许nil的存在
        
    }
    
    /// flatMap  (flat使变平)
    func flatMap1() {
        
        let array = [[7, 8, 9], [1, 2, 3]]
//        let result = array.flatMap { $0 }
//        print("result ======== \(result)")
        
        let result = array.flatMap { $0.map { $0 - 1 } }
        print("result ======== \(result)")
        
    }
    
    /// compactMap (compact：把...压实，简洁) 去掉数组中的nil
    func compactMap1() {
        
//        let arr = [1, 5, nil, 4]
//                let result = arr.compactMap {
//                    $0
//                }
        
        let array = [1, 5, nil, 4]
        let result = array.compactMap { $0 }
        print("result ======== \(result)")
        
        let stringArr = array.compactMap { $0 }.compactMap { String($0) }
        print("stringArr ======== \(stringArr)")
        
    }
    
    /// 过滤
    func filer1() {
        
        let arr = [1, 2, 3, 4, 5]
        let result = arr.filter {
            $0 > 3
        }
        print("result ======== \(result)")
        
    }
    
    /// 归约：reduce接受一个初始值（函数的返回值）和一个函数作为参数
    func reduce1() {
        
        let array = [5, 4, 3, 2, 1, 0]
//        let sum = array.reduce(0) { a, b in
//            a + b
//        }
//        let sum = array.reduce(0, { $0 + $1 })
        let sum = array.reduce(0, +)
        print("sum ======== \(sum)")
        
    }
    
    /// 遍历
    func forEach1() {
        
        let array = [3, 9, 2, 8, 4, 7, 1, 5]
        array.forEach {
            print("-------- \($0)")
        }
        
    }
    
    /// zip：函数将两个序列组合在一起，生成一个元组序列，其中每个元组包含两个序列中相应位置的元素
    func zip1() {
        
        let arr1: [Any] = [1, "2", 3]
        let arr2 = ["学习", "锻炼", "泡妞"]
        let zipArr = zip(arr1, arr2).map { $0 }
        
        print("zipArr ======= \(zipArr)")
        
    }
    
    /// prefix(while:) 函数 (当遇到第一个不满足条件的元素时候，终止，取前面满足条件的元素组成一个新的序列)
    func prefixWhile() {
        
        let array = [2, 4, 6, 7, 8, 10, 12]
        let result = array.prefix(while: { $0 < 8 })
        let evenPrefix = array.prefix(while: { $0 % 2 == 0 })
        print("result ======= \(result)")
        print("evenPrefix ======= \(evenPrefix)")
        
    }
    
    /// first(where:) 返回满足条件的第一个元素
    func firstWhere() {
        
        let array = [1, 2, 3, 4, 5, 6, 7]
        let result = array.first(where: { $0 % 2 == 0 })
        print("result ======= \(result)")
        
    }
    
    /// allSatisfy
    func allSatisfy() {
        
        let numbers = [2, 4, 6, 8, 10]
        let result = numbers.allSatisfy { $0 % 2 == 0 }
        print(result ? "true": "false")
    
    }
    
}
