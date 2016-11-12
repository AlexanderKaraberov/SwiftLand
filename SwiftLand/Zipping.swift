//
//  Zipping.swift
//  SwiftLand
//
//  Created by Alexander on 12/9/15.
//  Copyright © 2015 Alexander Karaberov. All rights reserved.
//

import Foundation

///zip3 takes three lists and returns a list of triples, analogous to zip.
public func zip3<A,B,C>(_ fst:[A], scd:[B], thrd:[C]) -> Array<(A,B,C)> {
    let size = min(fst.count, scd.count, thrd.count)
    var newArr = Array<(A,B,C)>()
    for x in 0..<size {
        newArr += [(fst[x], scd[x], thrd[x])]
    }
    return newArr
}

///zipWith generalises zip by zipping with the function given as the first argument,
///instead of a tupling function.
///For example, zipWith (+) is applied to two lists to produce the list of corresponding sums.
public func zipWith<A,B,C>(_ fst:[A], scd:[B], f:((A, B) -> C)) -> Array<C> {
    let size = min(fst.count, scd.count)
    var newArr = [C]()
    for x in 0..<size {
        newArr += [f(fst[x], scd[x])]
    }
    return newArr
}

///The zipWith3 function takes a function which combines three elements, as well as three lists
///and returns a list of their point-wise combination, analogous to zipWith.
public func zipWith3<A,B,C,D>(_ fst:[A], scd:[B], thrd:[C], f:((A, B, C) -> D)) -> Array<D> {
    let size = min(fst.count, scd.count, thrd.count)
    var newArr = [D]()
    for x in 0..<size {
        newArr += [f(fst[x], scd[x], thrd[x])]
    }
    return newArr
}

/// Unzips an array of tuples into a tuple of arrays.
public func unzip<T, U>(_ array: [(T, U)]) -> ([T], [U]) {
    
    var t = Array<T>()
    var u = Array<U>()
    for (a, b) in array {
        t.append(a)
        u.append(b)
    }
    return (t, u)
}

/// Unzips an array of triples into a triple of arrays.
public func unzip3<T, U, V>(_ array: [(T, U, V)]) -> ([T], [U], [V]) {
    
    var t = Array<T>()
    var u = Array<U>()
    var v = Array<V>()
    for (a, b, c) in array {
        t.append(a)
        u.append(b)
        v.append(c)
    }
    return (t, u, v)
}
