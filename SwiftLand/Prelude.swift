//
//  Prelude.swift
//  SwiftLand
//
//  Created by Alexander on 8/28/15.
//  Copyright (c) 2015 Alexander Karaberov. All rights reserved.
//

import Foundation


/// The identity function; always returns its argument.
public func id<T>(x: T) -> T {
    return x
}


/// K- combinator : constant combinator ignores its second argument and always returns its first argument.
public func const<A, B>(x : A) -> B -> A {
    return { (_) in
        return x
    }
}


/// Returns a pair with its fields in the opposite order.
public func swap<A, B>(a: A, b: B) -> (B, A) {
    return (b, a)
}


/// S-combinator Applies the second function to a value, then applies the first function to a value and the
/// result of the previous function application.
public func substitute<R, A, B>(f : R -> A -> B) -> (R -> A) -> R -> B {
    return { g in { x in f(x)(g(x)) } }
}

/// A type-restricted version of const.  In cases of typing ambiguity, using this function forces
/// its first argument to resolve to the type of the second argument.
public func asTypeOf<A>(x : A) -> A -> A {
    return const(x)
}

/// Returns the least fixed point of the function returned by `f`.
///
/// This is useful for e.g. making recursive closures without using the two-step assignment dance.
///
/// \param f  - A function which takes a parameter function, and returns a result function. The result function may recur by calling the parameter function.
///
/// \return  A recursive function.
public func fix<T, U>(f: (T -> U) -> T -> U) -> T -> U {
    return { f(fix(f))($0) }
}

/// Returns a binary function which calls `f` with its arguments reversed.
///
/// I.e. `flip(f)(x, y)` is equivalent to `f(y, x)`.
public func flip<T, U, V>(f: (T, U) -> V) -> (U, T) -> V {
    return { f($1, $0) }
}

/// Returns a ternary function which calls `f` with its arguments reversed.
///
/// I.e. `flip(f)(x, y, z)` is equivalent to `f(z, y, x)`.
public func flip<T, U, V, W>(f: (T, U, V) -> W) -> (V, U, T) -> W {
    return { f($2, $1, $0) }
}

/// Returns a quaternary function which calls `f` with its arguments reversed.
///
/// I.e. `flip(f)(w, x, y, z)` is equivalent to `f(z, y, x, w)`.
public func flip<T, U, V, W, X>(f: (T, U, V, W) -> X) -> (W, V, U, T) -> X {
    return { f($3, $2, $1, $0) }
}

/// On | P-combinator (Psi) Applies the function on its right to both its arguments, then applies the function on its
/// left to the result of both prior applications.
///
///    (+) |*| f = { x in { y in f(x) + f(y) } }
public func on<A, B, C>(o : B -> B -> C) -> (A -> B) -> A -> A -> C {
    return { f in { x in { y in o(f(x))(f(y)) } } }
}

/// On | P-combinator (Psi) Applies the function on its right to both its arguments, then applies the function on its
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