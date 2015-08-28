//
//  ArrayZipper.swift
//  SwiftLand
//
//  Created by Alexander on 8/28/15.
//  Copyright (c) 2015 Alexander Karaberov. All rights reserved.
//

import Foundation


/// A zipper for arrays.  Zippers are convenient ways of traversing and modifying the parts of a
/// structure using a cursor to focus on its individual parts.
///The Zipper is an idiom that uses the idea of “context” to the means of manipulating locations in a data structure.
///It can be used when you want to manipulate a location inside a data structure, rather than the data itself.
public struct ArrayZipper<A> : ArrayLiteralConvertible {
    typealias Element = A
    
    public let values : [A]
    public let position : Int
    
    public init(_ values : [A] = [], _ position : Int = 0) {
        if position < 0 {
            self.position = 0
        } else if position >= values.count {
            self.position = values.count - 1
        } else {
            self.position = position
        }
        self.values = values
    }
    
    public init(arrayLiteral elements : Element...) {
        self.init(elements, 0)
    }
    
    public func move(n : Int = 1) -> ArrayZipper<A> {
        return ArrayZipper(values, position + n)
    }
    
    public func moveTo(pos : Int) -> ArrayZipper<A> {
        return ArrayZipper(values, pos)
    }
}