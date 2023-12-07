//
//  SandboxCacheUtil.swift
//  ZJPersonal
//
//  Created by Jercan on 2023/12/6.
//

import Foundation
import WebKit

struct SandboxCacheUtil {}

extension SandboxCacheUtil {
    
    static func calculateCacheSize(completion: @escaping (Int) -> Void) {
        
        let cachePath = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first!
        let docuPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        
        DispatchQueue.global().async {
            let size = folderSizeAt(path: cachePath) + folderSizeAt(path: docuPath)
            DispatchQueue.main.async {
                completion(size)
            }
        }
        
    }
    

    static func clearCache(completion: @escaping () -> Void) {
        
        let cachePath = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first!
        let docuPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        
        DispatchQueue.global().async {
            
            clearFileAt(path: cachePath)
            clearFileAt(path: docuPath)
            clearSnapshots()
            
            DispatchQueue.main.async {
                completion()
            }
            
        }
        
        clearWebCache()
        
    }
    
    
}

private extension SandboxCacheUtil {
    
    static func folderSizeAt(path: String) -> Int {
        
        let manager = FileManager.default
        var size = 0
        if manager.fileExists(atPath: path) {
            let childrens = manager.subpaths(atPath: path) ?? []
            childrens.forEach {
                let absolutePath = (path as NSString).appendingPathComponent($0)
                do {
                    let fileSize = try manager.attributesOfItem(atPath: absolutePath)[.size] as? Int
                    size += fileSize ?? 0
                } catch {
                    debugPrint("error")
                }
            }
        }
        return size
        
    }
    
    static func clearFileAt(path: String) {
        
        let manager = FileManager.default
        
        manager.enumerator(atPath: path)?.forEach {
            let fileName = ($0 as? String) ?? ""
            let filePath = (path as NSString).appendingPathComponent(fileName)
            try? manager.removeItem(atPath: filePath)
        }
        
    }
    
    private static func clearSnapshots() {
        
        if #available(iOS 13.0, *) {
            let libPath = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true).first ?? ""
            let snapshotsPath = libPath + "/SplashBoard/Snapshots"
            let enumerator = FileManager.default.enumerator(atPath: snapshotsPath)
            while let path = enumerator?.nextObject() as? String {
                try? FileManager.default.removeItem(atPath: "\(snapshotsPath)/\(path)")
            }
        }
        
    }
    
    private static func clearWebCache() {
        
        let types = WKWebsiteDataStore.allWebsiteDataTypes()
        let date = Date(timeIntervalSince1970: 0)
        WKWebsiteDataStore.default().removeData(ofTypes: types, modifiedSince: date, completionHandler: { })
        
    }
    
}
