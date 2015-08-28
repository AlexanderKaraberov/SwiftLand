//
//  Semigroup.swift
//  SwiftLand
//
//  Created by Alexander on 8/28/15.
//  Copyright (c) 2015 Alexander Karaberov. All rights reserved.
//

import Foundation


/// A Semigroup is a type with a closed, associative, binary operator.
public protocol Semigroup  {
    
    /// An associative binary operator.
    func op(other : Self) -> Self
}

public func <> <A : Semigroup>(lhs : A, rhs : A) -> A {
    return lhs.op(rhs)
}

public func sconcat<S: Semigroup>(h : S, t : [S]) -> S {
    return t.reduce(h) { $0.op($1) }
}
