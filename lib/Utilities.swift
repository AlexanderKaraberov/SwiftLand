//
//  Utils.swift
//  SwiftLand
//
//  Created by Alexander on 8/27/15.
//  Copyright (c) 2015 Alexander Karaberov. All rights reserved.
//

import Foundation


/// Applies a function to an argument until a given predicate returns true.
public func until<A>(_ p : @escaping (A) -> Bool) -> ( @escaping (A) -> A) -> (A) -> A {
    return { f in { x in p(x) ? x : until(p)(f)(f(x)) } }
}


/// Returns a pair with its fields in the opposite order.
public func swap<A, B>(_ a: A, b: B) -> (B, A) {
    return (b, a)
}


/// Equality operator for pairs (2-tuples)
/// Used internally for testing
public func == <T:Equatable, U:Equatable>(lhs: (T,[U]), rhs: (T,[U])) -> Bool {
    let (l0,l1) = lhs
    let (r0,r1) = rhs
    return l0 == r0 && l1 == r1
}
