//
//  Monad.swift
//  SwiftLand
//
//  Created by Alexander on 8/28/15.
//  Copyright (c) 2015 Alexander Karaberov. All rights reserved.
//

import Foundation


/// Monads are Monoids lifted into category theory.
public protocol Monad : Applicative {
    /// Sequences and composes two monadic actions by passing the value inside the monad on the left
    /// to a function on the right yielding a new monad.
    func bind(f : A -> FB) -> FB
}