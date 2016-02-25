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
    
    func testArrayFromRange() {
        
        let withArray: [Int] = (2...9).toArray()
        
        XCTAssert(withArray == [2, 3, 4, 5, 6, 7, 8, 9], "Should be equal")
        XCTAssert(withArray != [2, 3, 4, 6, 7, 8, 9], "Should be equal")
    }
    
    func testUnfoldr() {
        
        let array = [3, 4, 5, 6, 7, 8, 9]
        let generatedArray = unfoldr {
            (seed: Int) -> Optional<(Int, Int)> in seed <= 9 ? .Some(seed, seed + 1) : .None } (3)
        
        XCTAssert(array == generatedArray, "Should be true")
    }
}