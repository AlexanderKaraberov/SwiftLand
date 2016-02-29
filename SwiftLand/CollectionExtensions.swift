//
//  CollectionExtensions.swift
//  SwiftLand
//
//  Created by Alexander on 11/5/15.
//  Copyright © 2015 Alexander Karaberov. All rights reserved.
//

import Foundation

public extension RangeReplaceableCollectionType where Self.Generator.Element: Hashable {
    
    /// Returns collection containing only unique elements of the receiver
    public func uniq() -> Self {
        var seen: Set<Self.Generator.Element> = Set()
        
        return reduce(Self()) { result, item in
            if seen.contains(item) {
                return result
            }
            seen.insert(item)
            return result + [item]
        }
    }
}


public protocol ArrayRepresentable {
   
    typealias ArrayType
    
    ///Allows to create an array from the given range
    func toArray() -> [ArrayType]
}


extension Range : ArrayRepresentable {
    
    ///Allows to create an array from the given range (lower...higher)
   public func toArray() -> [Element] {
        return [Element](self)
    }
}


/// Inserts a list in between the elements of a 2-dimensional array and concatenates the result.
public func intercalate<A>(list : [A], nested : [[A]]) -> [A] {
    return concat(nested.intersperse(list))
}

/// Concatenate a list of lists.
public func concat<T>(list : [[T]]) -> [T] {
    return list.reduce([], combine: +)
}

/// Returns the result of concatenating the values in the left and right arrays together.
public func concatenate<T>(lhs: [T])(_ rhs : [T]) -> [T] {
    return lhs + rhs
}

/// unfoldr is the dual to foldr.  Where foldr reduces an array given a function and an initial
/// value, unfoldr uses the initial value and the function to iteratively build an array.  If array
/// building should continue the function should return .Some(x, y), else it should return .None.
/// An unfold on arrays would build a (potentially infinite) array from a seed value.
/// Unfoldr is an anamorphism. Formally, anamorphisms are generic functions that can corecursively
/// construct a result of a certain type and which is parameterized by functions that determine
/// the next single step of the construction.
public func unfoldr<A, B>(f : B -> Optional<(A, B)>) -> B -> [A] {
    return { b in
        switch f(b) {
       
        case .Some(let (a, b2)):
            var array = unfoldr(f)(b2)
            array.insert(a, atIndex: 0)
            return array
        
        case .None:
            return []
        }
    }
}

/// The same as unfoldr, implemented in imperative style underhood
func unfold<T, U>(p: T -> Bool, h: T -> U, t: T -> T, a: T) -> [U] {
    if p(a) {
        return [U]()
    } else {
        return [h(a)] + unfold(p, h: h, t: t, a: t(a))
    }
}


/// Hylomorphism
/// Usage: func fac(n: Int) -> Int {
/// return hylo(1, f: *, g: {n in (n, n - 1)}, p: {$0 == 0}, t: n) }
public func hylo<T,U,V>(v: V, f: (U, V) -> V, g: T -> (U, T), p: T -> Bool, t: T) -> V {
    if p(t) {
        return v
    } else {
        let (u, t_) = g(t)
        return f(u, hylo(v, f: f, g: g, p: p, t: t_))
    }
}


/** Paramorphism
   
    Usage:
 
     func tails<T>(array: [T]) -> [[T]] {
         return paraList([[T]](), array: array){x, xs, tls in return [xs] + tls } }
**/
public func para<T, U>(b: U, array: [T], f: (T, [T], U) -> U) -> U {
    if array.isEmpty {
        return b
    } else {
        return f(array.first!, array, para(b, array: Array(array[1..<array.count]), f: f))
    }
}

