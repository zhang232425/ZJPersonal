//
//  UIResponder+Extension.swift
//  ZJPersonal
//
//  Created by Jercan on 2023/12/4.
//

import Foundation

extension UIResponder {
    
    @objc func handleEvent(name: String, userInfo: [AnyHashable: Any]) {
        
        if let hander = next {
            hander.handleEvent(name: name, userInfo: userInfo)
        }
        
    }
    
}

protocol CommonResponderEvent {
    
    var name: String { get }
    
    func post(by responder: UIResponder)
    
}

extension CommonResponderEvent {
    
    var name: String { "\(Self.self).\(self)" }
    
    func post(by responder: UIResponder) {
        
        responder.handleEvent(name: name, userInfo: [:])
        
    }
    
}
