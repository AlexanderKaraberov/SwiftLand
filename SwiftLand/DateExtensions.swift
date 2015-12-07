//
//  DateExtensions.swift
//  SwiftLand
//
//  Created by Alexander on 8/31/15.
//  Copyright (c) 2015 Alexander Karaberov. All rights reserved.
//

import Foundation


extension NSDate
{
    
    ///Init date using a string representation and a format
    ///format - is an optional formal parameter with default value "dd MM yyyy"
    convenience
    init(dateString: String, format: String = "dd MM yyyy") {
        let dateStringFormatter = NSDateFormatter()
        dateStringFormatter.dateFormat = format
        dateStringFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        let date = dateStringFormatter.dateFromString(dateString)!
        self.init(timeInterval:0, sinceDate:date)
    }
    
    ///Returns String representation of the given date, accordingly to passed date format
    public func stringifyDateWithFormat(format: String) -> String {
        
        let dateStringFormatter = NSDateFormatter()
        dateStringFormatter.dateFormat = format
        dateStringFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        return dateStringFormatter.stringFromDate(self)
    }
}

