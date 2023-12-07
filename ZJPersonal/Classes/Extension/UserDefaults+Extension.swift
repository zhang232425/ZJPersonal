//
//  UserDefaults+Extension.swift
//  ZJPersonal
//
//  Created by Jercan on 2023/12/6.
//

import Foundation

protocol UserDefaultsSettable {}

extension String:   UserDefaultsSettable {}
extension Bool:     UserDefaultsSettable {}
extension Int:      UserDefaultsSettable {}
extension Double:   UserDefaultsSettable {}
extension Float:    UserDefaultsSettable {}
extension URL:      UserDefaultsSettable {}
extension Data:     UserDefaultsSettable {}
extension Array:    UserDefaultsSettable where Element == String {}
extension Dictionary: UserDefaultsSettable where Key == String {}

@propertyWrapper
struct Defaults<T: UserDefaultsSettable> {
    
    let key: String
    let defaultValue: T
    
    init(_ key: String, context: String = #function, defaultValue: T) {
        self.key = "\(context).\(key)"
        self.defaultValue = defaultValue
    }
    
    var wrappedValue: T {
        get {
            UserDefaults.standard.value(forKey: key) as? T ?? defaultValue
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: key)
            UserDefaults.standard.synchronize()
        }
    }
    
}

extension UserDefaults {
    
    struct VersionInfo {
        
        @Defaults("hasNew", defaultValue: false)
        static var hasNew
        
        @Defaults("updateLink", defaultValue: "")
        static var updateLink
        
        @Defaults("borrowToken", defaultValue: "")
        static var borrowToken
        
    }
    
}
