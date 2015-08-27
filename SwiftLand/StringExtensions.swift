//
//  StringExtensions.swift
//  SwiftLand
//
//  Created by Alexander on 8/27/15.
//  Copyright (c) 2015 Alexander Karaberov. All rights reserved.
//

import Foundation

extension String {
    
    ////Check if string contains only decimal digits in it
    public func containsOnlyDigits() -> Bool {
        
        let nonDigits = NSCharacterSet.decimalDigitCharacterSet().invertedSet
        return self.rangeOfCharacterFromSet(nonDigits) == .None
        
    }
    
    //Check if string contains only letters in it
    public func containsOnlyCharacters() -> Bool {
        
        let nonCharacters = NSCharacterSet.letterCharacterSet().invertedSet
        return self.rangeOfCharacterFromSet(nonCharacters) == .None
        
    }
}