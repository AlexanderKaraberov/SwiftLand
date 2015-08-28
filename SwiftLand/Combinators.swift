//
//  Combinators.swift
//  SwiftLand
//
//  Created by Alexander on 8/28/15.
//  Copyright (c) 2015 Alexander Karaberov. All rights reserved.
//

import Foundation


/// The identity function.
public func identity<A>(a : A) -> A {
    return a
}

/// The constant combinator ignores its second argument and always returns its first argument.
public func const<A, B>(x : A) -> B -> A {
    return { _ in x }
}

/// Flip a function's arguments
public func flip<A, B, C>(f : ((A, B) -> C), b : B, a : A) -> C {
    return f(a, b)
}


/// Pipe Backward | Applies the function to its left to an argument on its right.
///
/// Because of this operator's extremely low precedence it can be used to elide parenthesis in
/// complex expressions.  For example:
///
///   f <| g <| h <| x  =  f (g (h x))
///
/// Acts as a synonym for §.
public func <| <A, B>(f : A -> B, a : A) -> B {
    return f(a)
}

/// Pipe forward | Applies an argument on the left to a function on the right.
///
/// Complex expressions may look more natural when expressed with this operator rather than normal
/// argument application.  For example:
///
///     { $0 * $0 }({ $0.advancedBy($0) }({ $0.advancedBy($0) }(1)))
///
/// can also be written as:
///
///     1 |> { $0.advancedBy($0) }
///       |> { $0.advancedBy($0) }
///       |> { $0 * $0 }
public func |> <A, B>(a : A, f : A -> B) -> B {
    return f(a)
}

/// The fixpoint (or Y) combinator computes the least fixed point of an equation. That is, the first
/// point at which further application of x to a function is the same x.
///
///     x = f(x)
public func fix<A>(f : ((A -> A) -> A -> A)) -> A -> A {
    return { x in f(fix(f))(x) }
}

/// On | Applies the function on its right to both its arguments, then applies the function on its
/// left to the result of both prior applications.
///
///    (+) |*| f = { x in { y in f(x) + f(y) } }
public func on<A, B, C>(o : B -> B -> C) -> (A -> B) -> A -> A -> C {
    return { f in { x in { y in o(f(x))(f(y)) } } }
}

/// On | Applies the function on its right to both its arguments, then applies the function on its
/// left to the result of both prior applications.
///
///    (+) |*| f = { x, y in f(x) + f(y) }
public func on<A, B, C>(o : (B, B) -> C) -> (A -> B) -> A -> A -> C {
    return { f in { x in { y in o(f(x), f(y)) } } }
}

/// Applies a function to an argument until a given predicate returns true.
public func until<A>(p : A -> Bool) -> (A -> A) -> A -> A {
    return { f in { x in p(x) ? x : until(p)(f)(f(x)) } }
}