//
//  Date+Extension.swift
//  ZJPersonal
//
//  Created by Jercan on 2023/12/12.
//

import Foundation
import SwiftDate

extension Date {

    static func formatter(with formatString: String) -> DateFormatter {
        let threadDic = Thread.current.threadDictionary
        let key = formatString as NSString
        var dateFormatter = threadDic.object(forKey: key) as? DateFormatter
        if dateFormatter == nil {
            dateFormatter = DateFormatter()
            dateFormatter!.dateFormat = formatString
            threadDic.setObject(dateFormatter!, forKey: key)
        }
        return dateFormatter!
    }
    
}

extension Date {
    
    var miliSecondsString: String {
        "\(miliSecondsInt)"
    }
    
    var miliSecondsNumber: NSNumber {
        .init(value: miliSecondsInt)
    }
    
    var miliSecondsInt: Int64 {
        Int64(timeIntervalSince1970 * 1000)
    }
    
    var dayOfNewEra: Int {
        calendar.ordinality(of: .day, in: .era, for: self) ?? 0
    }
}

extension TimeInterval {
    
    func dateString(format: String) -> String {
        
        let date = Date(seconds: self)
        
        return date.formatter(format: format) {
            $0.locale = Locales.indonesianIndonesia.toLocale()
            $0.timeZone = Zones.current.toTimezone()
        }.string(from: date)
        
    }
    
}
