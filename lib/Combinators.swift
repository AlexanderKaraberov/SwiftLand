//
//  Prelude.swift
//  SwiftLand
//
//  Created by Alexander on 8/28/15.
//  Copyright (c) 2015 Alexander Karaberov. All rights reserved.
//

import Foundation

//To Mock a Mockingbird by Smullyan
//Bird monickered combinators


/// I-combinator The identity function; always returns its argument.
public func id<T>(_ x: T) -> T {
    return x
}


/// K-combinator : constant combinator ignores its second argument and always returns its first argument.
public func const<A, B>(_ x : A) -> (B) -> A {
    return { (_) in
        return x
    }
}


/// S-combinator Applies the second function to a value, then applies the first function to a value and the
/// result of the previous function application.
public func substitute<R, A, B>(_ f : @escaping (R) -> (A) -> B) -> ( @escaping (R) -> A) -> (R) -> B {
    return { g in { x in f(x)(g(x)) } }
}


/// Y-combinator
/// Returns the least fixed point of the function returned by `f`.
///
/// This is useful for e.g. making recursive closures without using the two-step assignment dance.
///
/// \param f  - A function which takes a parameter function, and returns a result function. The result function may recur by calling the parameter function.
///
/// \return  A recursive function.
public func fix<T, U>(_ f: @escaping ((T) -> U) -> (T) -> U) -> (T) -> U {
    return { f(fix(f))($0) }
}


///C-combinator (2,3,4-arity)
/// Returns a binary function which calls `f` with its arguments reversed.
///
/// I.e. `flip(f)(x, y)` is equivalent to `f(y, x)`.
public func flip<T, U, V>(_ f: @escaping (T, U) -> V) -> (U, T) -> V {
    return { f($1, $0) }
}
/// Returns a ternary function which calls `f` with its arguments reversed.
///
/// I.e. `flip(f)(x, y, z)` is equivalent to `f(z, y, x)`.
public func flip<T, U, V, W>(_ f: @escaping (T, U, V) -> W) -> (V, U, T) -> W {
    return { f($2, $1, $0) }
}
/// Returns a quaternary function which calls `f` with its arguments reversed.
///
/// I.e. `flip(f)(w, x, y, z)` is equivalent to `f(z, y, x, w)`.
public func flip<T, U, V, W, X>(_ f: @escaping (T, U, V, W) -> X) -> (W, V, U, T) -> X {
    return { f($3, $2, $1, $0) }
}


precedencegroup RightApplyPrecedence {
    associativity: right
    higherThan: AssignmentPrecedence
    lowerThan: TernaryPrecedence
}
infix operator § : RightApplyPrecedence

///A-combinator - apply / applicator (also called i-star)
//func § <A, B>(A -> B, A) -> B
func § <A,B> (f: @escaping (A) -> B, a: A) -> B {
    return f(a)
}

precedencegroup CompositionPrecedence {
    associativity: right
    higherThan: BitwiseShiftPrecedence
}
infix operator >>> : CompositionPrecedence

///B-combinator (bluebird) or compose
public func >>> <A, B, C> (f: @escaping (B) -> C, g: @escaping (A) -> B) -> (A) -> C {
    return { x in f(g(x)) }
}


///W-combinator (elementary duplicator)
public func duplicate <A, B> (f: @escaping (A) -> B, a: A) -> (A, A) -> B {
    return { x, _ in f(a) }
}


///Psi-combinator
///Applies the function on its right to both its arguments, then applies the function on its
/// left to the result of both prior applications.
///
///    (+) |*| f = { x in { y in f(x) + f(y) } }
public func on<A, B, C>(_ o : @escaping (B) -> (B) -> C) -> ( @escaping (A) -> B) -> (A) -> (A) -> C {
    return { f in { x in { y in o(f(x))(f(y)) } } }
}

