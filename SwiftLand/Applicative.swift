//
//  Applicative.swift
//  SwiftLand
//
//  Created by Alexander on 8/28/15.
//  Copyright (c) 2015 Alexander Karaberov. All rights reserved.
//

import Foundation


/// Applicative sits in the middle distance between a Functor and a Monad.  An Applicative Functor
/// is a Functor equipped with a function (called point or pure) that takes a value to an instance
/// of a functor containing that value. Applicative Functors provide the ability to operate on not
/// just values, but values in a functorial context such as Eithers, Lists, and Optionals without
/// needing to unwrap or map over their contents.
public protocol Applicative : Functor {
    /// Type of Functors containing morphisms from our objects to a target.
    typealias FAB = K1<A -> B>
    
    /// Applies the function encapsulated by the Functor to the value encapsulated by the receiver.
    func ap(f : FAB) -> FB
}