//
//  Bundle+Extension.swift
//  ZJPersonal
//
//  Created by Jercan on 2023/12/1.
//

import Foundation

extension Bundle {
    
    static var framework_ZJPersonal: Bundle {
        let frameworkName = "ZJPersonal"
        let resourcePath: NSString = .init(string: Bundle(for: ZJPersonalClass.self).resourcePath ?? "")
        let path = resourcePath.appendingPathComponent("/\(frameworkName).bundle")
        return Bundle(path: path)!
    }
    
    private class ZJPersonalClass {}
    
}
