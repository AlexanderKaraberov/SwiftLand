//
//  Prelude.swift
//  SwiftLand
//
//  Created by Alexander on 8/28/15.
//  Copyright (c) 2015 Alexander Karaberov. All rights reserved.
//

import Foundation


/// The identity function; returns its argument.
public func id<T>(x: T) -> T {
    return x
}


/// Returns a function which ignores its argument and returns `x` instead.
public func const<T, U>(x: T?) -> U -> T? {
    return { _ in x }
}


/// Returns a pair with its fields in the opposite order.
public func swap<A, B>(a: A, b: B) -> (B, A) {
    return (b, a)
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