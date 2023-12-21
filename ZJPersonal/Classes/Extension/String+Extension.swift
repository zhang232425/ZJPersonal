//
//  Doubel+Extension.swift
//  ZJPersonal
//
//  Created by Jercan on 2023/12/20.
//

import Foundation

/*
 extension String: NamespaceWrappable {}
 
 extension NamespaceWrapper where T == String {
 
 func numberCount() -> Int {
 
 var count = 0
 for c in warppedValue where ("0" ... "9").contains(c) {
 count += 1
 }
 return count
 
 }
 
 }
 */

/***
 * 面向协议编程，<前缀>.<方法>
 * 这个前缀是一个属性
 */

/*
extension String {
    
    func numberCount(string: String) -> Int {
        var count = 0
        for c in string where ("0" ... "9").contains(c) {
            count += 1
        }
        return count
    }

}
 */

/// 问题：如果其他类型也想实现<前缀>.<方法>
/*
struct SHBase {
    
    var string: String
    
    func numberCount() -> Int {
        var count = 0
        for c in string where ("0" ... "9").contains(c) {
            count += 1
        }
        return count
    }
    
}

extension String {
    
    var sh: SHBase { SHBase(string: self) }
    
}
*/

/// 泛型
struct SHBase<Base> {
    var base: Base
    init(base: Base) {
        self.base = base
    }
}

extension String {
    
    var sh: SHBase<String> { SHBase(base: self) }

}

/// 怎么扩展方法
/// 通过 extension 给前缀类型添加一个 numberCount 方法，在 extension 中判断前缀类型的泛型是否是 String。

extension SHBase where Base == String {
    
    func numberCount() -> Int {
        var count = 0
        for c in base where ("0" ... "9").contains(c) {
            count += 1
        }
        return count
    }
    
}

extension SHBase where Base == Double {
    
    func double() -> Double {
        return 137.0
    }
    
}

/***
 * <前缀>.<方法>
 * 声明一个泛型类型前缀类型
 * 给需要添加扩展方法的类型以 extension 的方式添加前缀类型属性
 * 最后给前缀类型扩展方法，在前缀类型的 extension 中判断泛型是否是需要扩展的类型并实现扩展的内容
 */

// 但此时还是不够完善，因为每次想给某个类型添加前缀的时候都要去 extension 中添加前缀类型属性。此时我们可以通过协议来解决这个问题

/**
 protocol SHCompatible {}
 extension SHCompatible {
     var sh: SHBase<Self> { SHBase(self) }
 }
 */


/**
 这里也是利用了协议的两个特性：一个是协议的 extension 可以添加计算属性和方法；一个是协议的 Self 可以还原出真实类型。此时只需要给需要添加扩展方法的类型遵守 SHCompatible 协议就拥有 sh 的前缀类型属性了。
 */
protocol SHCompatiable {}

extension SHCompatiable {
    
    var sh: SHBase<Self> { SHBase(base: self) }
    static var sh: SHBase<Self>.Type { SHBase<Self>.self }
}
