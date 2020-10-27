//
//  Common.swift
//  SecuX EvPay
//
//  Created by maochun on 2020/7/23.
//  Copyright © 2020 SecuX. All rights reserved.
//

import Foundation

class Common{
    
    static func localToUTC(date:String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd H:mm:ss"
        dateFormatter.calendar = NSCalendar.current
        dateFormatter.timeZone = TimeZone.current

        guard let dt = dateFormatter.date(from: date) else{
            return nil
        }
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")


        return dateFormatter.string(from: dt)
    }

    static func UTCToLocal(date:String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd H:mm:ss"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")

        guard let dt = dateFormatter.date(from: date) else{
            return nil
        }
        dateFormatter.timeZone = TimeZone.current

        return dateFormatter.string(from: dt)
    }
    
    
}
