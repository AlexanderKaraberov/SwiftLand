//
//  Folds.swift
//  SwiftLand
//
//  Created by Alexander on 8/31/15.
//  Copyright (c) 2015 Alexander Karaberov. All rights reserved.
//

import Foundation

/// Takes a binary function, a starting value, and an array of values, then folds the function over
/// the array from left to right to yield a final value.
public func foldl<A, B>(f: B -> A -> B) -> B -> [A] -> B {
    return { z in { l in
        switch match(l) {
        case .Nil:
            return z
        case .Cons(let x, let xs):
            return foldl(f)(f(z)(x))(xs)
        }
        } }
}

/// Takes a binary operator, a starting value, and an array of values, then folds the function over
/// the array from left to right to yield a final value.
public func foldl<A, B>(f: (B, A) -> B) -> B -> [A] -> B {
    return { z in { l in
        switch match(l) {
        case .Nil:
            return z
        case .Cons(let x, let xs):
            return foldl(f)(f(z, x))(xs)
        }
        } }
}


/// Takes a binary function and an array of values, then folds the function over the array from left
/// to right.  It takes its initial value from the head of the array.
///
/// Because this function draws its initial value from the head of an array, it is non-total with
/// respect to the empty array.
public func foldl1<A>(f: A -> A -> A) -> [A] -> A {
    return { l in
        switch match(l) {
        case .Cons(let x, let xs) where xs.count == 0:
            return x
        case .Cons(let x, let xs):
            return foldl(f)(x)(xs)
        case .Nil:
            fatalError("Cannot invoke foldl1 with an empty list.")
        }
    }
}

/// Takes a binary operator and an array of values, then folds the function over the array from left
/// to right.  It takes its initial value from the head of the array.
///
/// Because this function draws its initial value from the head of an array, it is non-total with
/// respect to the empty array.
public func foldl1<A>(f: (A, A) -> A) -> [A] -> A {
    return { l in
        switch match(l) {
        case .Cons(let x, let xs) where xs.count == 0:
            return x
        case .Cons(let x, let xs):
            return foldl(f)(x)(xs)
        case .Nil:
            fatalError("Cannot invoke foldl1 with an empty list.")
        }
    }
}


/// Takes a binary function, a starting value, and an array of values, then folds the function over
/// the array from right to left to yield a final value.
public func foldr<A, B>(k: A -> B -> B) -> B -> [A] -> B {
    return { z in { l in
        switch match(l) {
        case .Nil:
            return z
        case .Cons(let x, let xs):
            return k(x)(foldr(k)(z)(xs))
        }
        } }
}

/// Takes a binary operator, a starting value, and an array of values, then folds the function over
/// the array from right to left to yield a final value.
public func foldr<A, B>(k: (A, B) -> B) -> B -> [A] -> B {
    return { z in { l in
        switch match(l) {
        case .Nil:
            return z
        case .Cons(let x, let xs):
            return k(x, foldr(k)(z)(xs))
        }
        } }
}


/// Takes a binary function and an array of values, then folds the function over the array from
/// right to left.  It takes its initial value from the head of the array.
///
/// Because this function draws its initial value from the head of an array, it is non-total with
/// respect to the empty array.
public func foldr1<A>(f: A -> A -> A) -> [A] -> A {
    return { l in
        switch match(l) {
        case .Cons(let x, let xs) where xs.count == 0:
            return x
        case .Cons(let x, let xs):
            return f(x)(foldr1(f)(xs))
        case .Nil:
            fatalError("Cannot invoke foldr1 with an empty list.")
        }
    }
}

/// Takes a binary operator and an array of values, then folds the function over the array from
/// right to left.  It takes its initial value from the head of the list.
///
/// Because this function draws its initial value from the head of an array, it is non-total with
/// respect to the empty array.
public func foldr1<A>(f: (A, A) -> A) -> [A] -> A {
    return { l in
        switch match(l) {
        case .Cons(let x, let xs) where xs.count == 0:
            return x
        case .Cons(let x, let xs):
            return f(x, foldr1(f)(xs))
        case .Nil:
            fatalError("Cannot invoke foldr1 with an empty list.")
        }
    }
}


/// Takes a function and an initial seed value and constructs an array.
///
/// unfoldr is the dual to foldr.  Where foldr reduces an array given a function and an initial
/// value, unfoldr uses the initial value and the function to iteratively build an array.  If array
/// building should continue the function should return .Some(x, y), else it should return .None.
public func unfoldr<A, B>(f : B -> Optional<(A, B)>) -> B -> [A] {
    return { b in
        switch f(b) {
        case .Some(let (a, b2)):
            return a <| unfoldr(f)(b2)
        case .None:
            return []
        }
    }
}

/// Returns the conjunction of an array of Booleans
public func and(l : [Bool]) -> Bool {
    return foldr({$0 && $1})(true)(l)
}

/// Returns the disjunction of an array of Booleans
public func or(l : [Bool]) -> Bool {
    return foldr({$0 || $1})(false)(l)
}

/// Maps a predicate over an array.  For the result to be true, the predicate must be satisfied at
/// least once by an element of the array.
public func any<A>(p : A -> Bool) -> [A] -> Bool {
    return { l in or(l.map(p)) }
}

/// Maps a predicate over an array.  For the result to be true, the predicate must be satisfied by
/// all elemenets of the array.
public func all<A>(p : A -> Bool) -> [A] -> Bool {
    return { l in and(l.map(p)) }
}



/// Concatenate an array of arrays.
public func concat<A>(xss : [[A]]) -> [A] {
    return foldr({ $0 + $1 })([])(xss)
}

/// Map a function over an array and concatenate the results.
public func concatMap<A, B>(f : A -> [B]) -> [A] -> [B] {
    return { l in foldr({ f($0) + $1 })([])(l) }
}


/// Returns the maximum value in an array of comparable values.
public func maximum<A : Comparable>(l : [A]) -> A {
    assert(l.count != 0, "Cannot find the maximum value of an empty list.")
    
    return foldl1(max)(l)
}

/// Returns the minimum value in an array of comparable values.
public func minimum<A : Comparable>(l : [A]) -> A {
    assert(l.count != 0, "Cannot find the minimum value of an empty list.")
    
    return foldl1(min)(l)
}


/// Returns the sum of an array of numbers.
public func sum<N : IntegerType>(l : [N]) -> N {
    return foldl({ $0 + $1 })(0)(l)
}

/// Returns the product of an array of numbers.
public func product<N : IntegerType>(l : [N]) -> N {
    return foldl({ $0 * $1 })(1)(l)
}
