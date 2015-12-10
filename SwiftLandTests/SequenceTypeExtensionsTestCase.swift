//
//  ArrayExtensionsTests.swift
//  SwiftLand
//
//  Created by Alexander on 12/10/15.
//  Copyright © 2015 Alexander Karaberov. All rights reserved.
//

import Foundation
import XCTest
import SwiftLand

class SequenceTypeExtensionsTestCase: XCTestCase {
    
    func testAll() {
        let withArray = [1,3,22,15]
        let withSet = Set(withArray)
        
        XCTAssert(withArray.all({ (element) -> Bool in
            element <= 22
        }), "Should be true")
        
        XCTAssert(withSet.all({ (element) -> Bool in
            element < 30
        }), "Should be true")
    }
    
    func testAny() {
        let withArray = [1,4,53,7,323,3]
        let withSet = Set(withArray)
        
        XCTAssert(withArray.any({ (element) -> Bool in
            element > 100
        }), "Should be true")
        
        XCTAssert(withSet.any({ (element) -> Bool in
            
            element < 2
        }), "Should be true")
    }
    
}