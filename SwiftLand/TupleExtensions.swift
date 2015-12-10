//
//  TupleExtensions.swift
//  SwiftLand
//
//  Created by Alexander on 12/10/15.
//  Copyright © 2015 Alexander Karaberov. All rights reserved.
//

import Foundation

///Equality operator for pairs (2-tuples)
public func == <T:Equatable, U:Equatable>(lhs: (T,U), rhs: (T,U)) -> Bool {
    let (l0,l1) = lhs
    let (r0,r1) = rhs
    return l0 == r0 && l1 == r1
}

/// Equality operator for pairs (2-tuples)
/// Used internally for testing
public func == <T:Equatable, U:Equatable>(lhs: (T,[U]), rhs: (T,[U])) -> Bool {
    let (l0,l1) = lhs
    let (r0,r1) = rhs
    return l0 == r0 && l1 == r1
}