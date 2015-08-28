//
//  Monoid.swift
//  SwiftLand
//
//  Created by Alexander on 8/28/15.
//  Copyright (c) 2015 Alexander Karaberov. All rights reserved.
//

import Foundation

/// A `Monoid` is a `Semigroup` that distinguishes an identity element.
public protocol Monoid : Semigroup {
    /// The identity element of the Monoid.
    static var mzero : Self { get }
}

public func mconcat<S : Monoid>(t : [S]) -> S {
    return sconcat(S.mzero, t)
}
