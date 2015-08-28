//
//  Functor.swift
//  SwiftLand
//
//  Created by Alexander on 8/28/15.
//  Copyright (c) 2015 Alexander Karaberov. All rights reserved.
//

import Foundation

/// Functors are mappings from the functions and objects in one set to the functions and objects
/// in another set.
public protocol Functor {
    /// Source
    typealias A
    /// Target
    typealias B
    /// A Target Functor
    typealias FB = K1<B>
    
    /// Map a function over the value encapsulated by the Functor.
    func fmap(f : A -> B) -> FB
}