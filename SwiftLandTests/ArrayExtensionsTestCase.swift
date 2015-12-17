//
//  ArrayExtensionsTestCase.swift
//  SwiftLand
//
//  Created by Alexander on 12/10/15.
//  Copyright © 2015 Alexander Karaberov. All rights reserved.
//

import Foundation
import SwiftLand
import XCTest


class ArrayExtensionsTestCase: XCTestCase {
    
    func testArrayProduct() {
    
        let withArray: [Int] = [3,4,1,2,2,1,3]
        
        XCTAssert(withArray.product() == 144, "Should be equal")
    }
    
    func testArraySum() {
    
        let withArray: [Int] = [2,4,1,0,3]
        XCTAssert(withArray.sum() == 10, "Should be equal")
    }
    
    func testNull() {
    
        let withArray1: [Int] = []
        let withArray2: [Int] = [2,3]
        
        XCTAssert(withArray1.null == true, "Should be true")
        XCTAssert(withArray2.null == false, "Should be false")
    }
    
    func testRemoveFunctions() {
    
        var withArray1: [Int] = [1, 343, 4, 3]
        var withArray2: [String] = ["a", "bc", "cda"]
        var withArray3: [String] = ["adsd", "aabc", "dddcda"]
        
        withArray1.removeObjectsInArray([1,3,5])
        
        withArray2.removeBy { (element) -> Bool in
            element.rangeOfString("cd") != nil
        }
        
        withArray3.removeObject("adsd")
      
        XCTAssert(withArray1 == [343, 4],           "Should be true")
        XCTAssert(withArray2 == ["a", "bc"],        "Should be true")
        XCTAssert(withArray3 == ["aabc", "dddcda"], "Should be true")
    }
    
    func testDecompose() {
    
        let withArray1: [Int] = [2,34,1,2,3]
        let withArray2: [Int] = []
        let withArray3: [Int] = [1]
    
        XCTAssert(withArray1.decompose! == (2, [34,1,2,3]), "Should be true")
        XCTAssert(withArray2.decompose == nil, "Should be true")
        XCTAssert(withArray3.decompose! == (1, []), "Should be true")
    }    
}