//
//  UIImage+Extension.swift
//  ZJPersonal
//
//  Created by Jercan on 2023/12/1.
//

import Foundation

extension UIImage {
    
    static func named(_ name: String) -> UIImage? {
        UIImage(name: name, bundle: .framework_ZJPersonal)
    }
    
}
