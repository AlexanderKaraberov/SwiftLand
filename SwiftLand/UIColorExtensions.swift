//
//  UIColorExtensions.swift
//  SwiftLand
//
//  Created by Alexander on 9/3/15.
//  Copyright (c) 2015 Alexander Karaberov. All rights reserved.
//

import Foundation


public extension UIColor {
    
    enum HexNotationType: Int {
        
        case ShorthandNoAlphaValue = 3
        case ShorthandWithAlphaValue = 4
        case StandardHexNoAlphaValue = 6
        case StandardHexWithAlphaValue = 8
    }
    
    
    ///Function from beautiful UIColor-Hex-Swift repo.
    ///Allows you to init UIColor with HEX string
    ///Supports usual 6 digits hex, shorthand 3 digits,
    ///and also supports alpha channel using the 7th and 8th characters of an 8 digit hex colour,
    ///or 4th character of a 4 digit hex colour from the `4.2. The RGB hexadecimal notations: #RRGGBB` of the CSS Level 4 draft
    public class func colorWithHexValue(hexValue: String) -> UIColor {
        
        var red:   CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue:  CGFloat = 0.0
        var alpha: CGFloat = 1.0
        
        if hexValue.hasPrefix("#") {
            let index   = hexValue.startIndex.advancedBy(1)
            let hex     = hexValue.substringFromIndex(index)
            let scanner = NSScanner(string: hex)
            var hexValue: CUnsignedLongLong = 0
            if scanner.scanHexLongLong(&hexValue) {
                
                guard let hexNotationType = HexNotationType(rawValue: hex.characters.count) else {
                    
                    print("Invalid RGB string, number of characters after '#' should be either 3, 4, 6 or 8")
                    return UIColor (red: red, green: green, blue: blue, alpha: alpha)
                }
                
                switch (hexNotationType) {
                    
                case .ShorthandNoAlphaValue:
                    red   = CGFloat((hexValue & 0xF00) >> 8)       / 15.0
                    green = CGFloat((hexValue & 0x0F0) >> 4)       / 15.0
                    blue  = CGFloat(hexValue & 0x00F)              / 15.0
                    
                case .ShorthandWithAlphaValue:
                    red   = CGFloat((hexValue & 0xF000) >> 12)     / 15.0
                    green = CGFloat((hexValue & 0x0F00) >> 8)      / 15.0
                    blue  = CGFloat((hexValue & 0x00F0) >> 4)      / 15.0
                    alpha = CGFloat(hexValue & 0x000F)             / 15.0
                    
                case .StandardHexNoAlphaValue:
                    red   = CGFloat((hexValue & 0xFF0000) >> 16)   / 255.0
                    green = CGFloat((hexValue & 0x00FF00) >> 8)    / 255.0
                    blue  = CGFloat(hexValue & 0x0000FF)           / 255.0
                    
                case .StandardHexWithAlphaValue:
                    red   = CGFloat((hexValue & 0xFF000000) >> 24) / 255.0
                    green = CGFloat((hexValue & 0x00FF0000) >> 16) / 255.0
                    blue  = CGFloat((hexValue & 0x0000FF00) >> 8)  / 255.0
                    alpha = CGFloat(hexValue & 0x000000FF)         / 255.0
                    
                }
            } else {
                print("Scan hex error")
                
            }
        }
        else {
            print("Invalid RGB string, missing '#' as prefix")
        }
        return UIColor (red: red, green: green, blue: blue, alpha: alpha)
    }
}
