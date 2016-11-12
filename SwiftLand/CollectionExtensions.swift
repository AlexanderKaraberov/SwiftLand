//
//  CollectionExtensions.swift
//  SwiftLand
//
//  Created by Alexander on 11/5/15.
//  Copyright © 2015 Alexander Karaberov. All rights reserved.
//

import Foundation

public extension RangeReplaceableCollection where Self.Iterator.Element: Hashable {
    
    /// Returns collection containing only unique elements of the receiver
    public func uniq() -> Self {
        var seen: Set<Self.Iterator.Element> = Set()
        
        return reduce(Self()) { result, item in
            if seen.contains(item) {
                return result
            }
            seen.insert(item)
            return result + [item]
        }
    }
}


public extension Dictionary {
    
    /// If the specified key is not already associated with a value
    /// attempts to compute its value using the given mapping function, enters it into this dictionary
    // and returns its value, otherwise returns value associated with the key
    public mutating func computeIfAbsent(_ k: Key, f: (Key) -> Value) -> Value {
        
        if let value = self[k] {
            return value
        }
            
        else {
            self[k] = f(k)
            return self[k]!
        }
    }
}


/// Inserts a list in between the elements of a 2-dimensional array and concatenates the result.
public func intercalate<A>(_ list : [A], nested : [[A]]) -> [A] {
    return concat(nested.intersperse(list))
}

/// Concatenate a list of lists.
public func concat<T>(_ list : [[T]]) -> [T] {
    return list.reduce([], +)
}

/// Returns the result of concatenating the values in the left and right arrays together.
public func concatenate<T>(_ lhs: [T], _ rhs : [T]) -> [T] {
    return lhs + rhs
}


/// Hylomorphism
/// Usage: func fac(n: Int) -> Int {
/// return hylo(1, f: *, g: {n in (n, n - 1)}, p: {$0 == 0}, t: n) }
public func hylo<T,U,V>(_ v: V, f: (U, V) -> V, g: (T) -> (U, T), p: (T) -> Bool, t: T) -> V {
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
public func para<T, U>(_ b: U, array: [T], f: (T, [T], U) -> U) -> U {
    if array.isEmpty {
        return b
    } else {
        return f(array.first!, array, para(b, array: Array(array[1..<array.count]), f: f))
    }
}

