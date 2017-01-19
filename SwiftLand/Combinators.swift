//
//  Prelude.swift
//  SwiftLand
//
//  Created by Alexander on 8/28/15.
//  Copyright (c) 2015 Alexander Karaberov. All rights reserved.
//

import Foundation

// MARK: Combinators: Functions

/*~
 * ---
 * name           : Identity
 * #              : I
 * category       : Combinators
 * description    : Returns its argument.
 * type signature : a → a
 *
 */

public func id<T>(_ x: T) -> T {
    return x
}

/*~
 * ---
 * name           : Constant
 * #              : K
 * category       : Combinators
 * description    : Takes two values and returns the first.
 * type signature : a → b → a
 *
 */

public func const<A, B>(_ x : A) -> (B) -> A {
    return { (_) in
        return x
    }
}

/*~
 * ---
 * name           : Substitution
 * #              : S
 * category       : Combinators
 * description    : Takes a curried binary function, an unary function,
                    and a value, and returns the result of applying 
                    the binary function to:
                    - the value; and
                    - the result of applying the unary function to the value.
 * type signature : (a → b → c) → (a → b) → a → c
 *
 */

public func substitute<R, A, B>(_ f : @escaping (R) -> (A) -> B) -> ( @escaping (R) -> A) -> (R) -> B {
    return { g in { x in f(x)(g(x)) } }
}

/*~
 * ---
 * name           : Fixed-Point
 * #              : Y
 * category       : Combinators
 * description    : Takes a functional as input, and it returns the (unique)
                    fixed point of that functional as its output. A 
                    functional is a function that takes a function for its input.
 * type signature : (a → a) → a
 *
 */

public func fix<T, U>(_ f: @escaping ((T) -> U) -> (T) -> U) -> (T) -> U {
    return { f(fix(f))($0) }
}


/*~
 * ---
 * name           : Flip (2-arity)
 * #              : C
 * category       : Combinators
 * description    : Takes a curried binary function and two values, and
                    returns the result of applying the function to the 
                    values in reverse order.
 * type signature : (a → b → c) → b → a → c
 *
 */

public func flip<T, U, V>(_ f: @escaping (T, U) -> V) -> (U, T) -> V {
    return { f($1, $0) }
}

// Flip (3-arity)

public func flip<T, U, V, W>(_ f: @escaping (T, U, V) -> W) -> (V, U, T) -> W {
    return { f($2, $1, $0) }
}

// Flip (4-arity)

public func flip<T, U, V, W, X>(_ f: @escaping (T, U, V, W) -> X) -> (W, V, U, T) -> X {
    return { f($3, $2, $1, $0) }
}

/*~
 * ---
 * name           : Apply
 * #              : A
 * category       : Combinators
 * description    : Takes a function and a value, and returns the result
                    of applying the function to the value.
 * type signature : (a → b) → a → b
 *
 */

public func § <A,B> (f: @escaping (A) -> B, a: A) -> B {
    return f(a)
}

/*~
 * ---
 * name           : Compose
 * #              : B
 * category       : Combinators
 * description    : Takes two functions and a value, and returns the
                    result of applying the first function to the result 
                    of applying the second to the value.
 * type signature : (b → c) → (a → b) → a → c
 *
 */

public func >>> <A, B, C> (f: @escaping (B) -> C, g: @escaping (A) -> B) -> (A) -> C {
    return { x in f(g(x)) }
}


/*~
 * ---
 * name           : Duplication
 * #              : W
 * category       : Combinators
 * description    : Behaves as an elementary duplicator
 * type signature : (a → a → b) → a → b
 *
 */

public func duplicate <A, B> (f: @escaping (A) -> B, a: A) -> (A, A) -> B {
    return { x in f(a) }
}

/*~
 * ---
 * name           : Psi
 * #              : P
 * category       : Combinators
 * description    : Applies the function on its right to both its arguments, 
                    then applies the function on its left to the result of 
                    both prior applications.
 * type signature : (b → b → c) → (a → b) → a → a → c
 *
 */

public func on<A, B, C>(_ o : @escaping (B) -> (B) -> C) -> ( @escaping (A) -> B) -> (A) -> (A) -> C {
    return { f in { x in { y in o(f(x))(f(y)) } } }
}

// MARK: Combinators: Operators

/*~
 * ---
 * name           : Apply
 * #              : A
 * category       : Combinators: Operators
 * associativity  : Right
 * description    : Takes a function and a value, and returns the result
                    of applying the function to the value.
 * type signature : (a → b) → a → b
 *
 */

precedencegroup RightApplyPrecedence {
    associativity: right
    higherThan: AssignmentPrecedence
    lowerThan: TernaryPrecedence
}

infix operator § : RightApplyPrecedence

/*~
 * ---
 * name           : Compose
 * #              : B
 * category       : Combinators: Operators
 * associativity  : Right
 * description    : Takes two functions and a value, and returns the
                    result of applying the first function to the result
                    of applying the second to the value.
 * type signature : (b → c) → (a → b) → a → c
 *
 */

precedencegroup CompositionPrecedence {
    associativity: right
    higherThan: BitwiseShiftPrecedence
}

infix operator >>> : CompositionPrecedence

