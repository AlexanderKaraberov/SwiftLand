//
//  TupleExtensions.swift
//  SwiftLand
//
//  Created by Alexander on 8/26/15.
//  Copyright (c) 2015 Alexander Karaberov. All rights reserved.
//

import Foundation

//Compare two-tuples (pairs)

func == <T:Equatable> (t1:(T,T),t2:(T,T)) -> Bool
{
    return (t1.0 == t2.0) && (t1.1 == t2.1)
}

/// Extract the first component of a pair.
public func fst<A, B>(t : (A, B)) -> A {
    return t.0
}

/// Extract the second component of a pair
public func snd<A, B>(t : (A, B)) -> B {
    return t.1
}

/// Converts an uncurried function to a curried function.
///
/// A curried function is a function that always returns another function or a value when applied
/// as opposed to an uncurried function which may take tuples.
public func curry<A, B, C>(f : (A, B) -> C) ->  A -> B -> C {
    return { a in
        return { b in
            return f(a, b)
        }
    }
}

/// Converts a curried function to an uncurried function.
///
/// An uncurried function may take tuples as opposed to a curried function which must take a single
/// value and return a single value or function.
public func uncurry<A, B, C>(f : A -> B -> C) -> (A, B) -> C {
    return { t in
        return f(fst(t))(snd(t))
    }
}
