//
//  Currying.swift
//  SwiftLand
//
//  Created by Alexander on 12/10/15.
//  Copyright © 2015 Alexander Karaberov. All rights reserved.
//

import Foundation


/// Converts an uncurried function to a curried function.
///
/// A curried function is a function that always returns another function or a value when applied
/// as opposed to an uncurried function which may take tuples.
public func curry<A, B, C>(_ f : @escaping (A, B) -> C) -> (A) -> (B) -> C {
    return { a in { b in f(a, b) } }
}

public func curry<A, B, C, D>(_ f : @escaping (A, B, C) -> D) -> (A) -> (B) -> (C) -> D {
    return { a in { b in { c in f(a, b, c) } } }
}

public func curry<A, B, C, D, E>(_ f : @escaping (A, B, C, D) -> E) -> (A) -> (B) -> (C) -> (D) -> E {
    return { a in { b in { c in { d in f(a, b, c, d) } } } }
}

public func curry<A, B, C, D, E, F>(_ f : @escaping (A, B, C, D, E) -> F) -> (A) -> (B) -> (C) -> (D) -> (E) -> F {
    return { a in { b in { c in { d in { e in f(a, b, c, d, e) } } } } }
}


/// Converts a curried function to an uncurried function.
///
/// An uncurried function may take tuples as opposed to a curried function which must take a single
/// value and return a single value or function.
public func uncurry<A, B, C>(_ f : @escaping (A) -> (B) -> C) -> (A, B) -> C {
    return { t in f(t.0)(t.1) }
}

public func uncurry<A, B, C, D>(_ f : @escaping (A) -> (B) -> (C) -> D) -> (A, B, C) -> D {
    return { a, b, c in f(a)(b)(c) }
}

public func uncurry<A, B, C, D, E>(_ f : @escaping (A) -> (B) -> (C) -> (D) -> E) -> (A, B, C, D) -> E {
    return { a, b, c, d in f(a)(b)(c)(d) }
}

public func uncurry<A, B, C, D, E, F>(_ f : @escaping (A) -> (B) -> (C) -> (D) -> (E) -> F) -> (A, B, C, D, E) -> F {
    return { a, b, c, d, e in f(a)(b)(c)(d)(e) }
}
