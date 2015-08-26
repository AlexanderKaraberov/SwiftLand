//
//  ArrayExtensions.swift
//  SwiftLand
//
//  Created by Alexander on 8/26/15.
//  Copyright (c) 2015 Alexander Karaberov. All rights reserved.
//

import Foundation

/// MARK: Array extensions

public enum ArrayMatcher<A> {
    case Nil
    case Cons(A, [A])
}

/// Destructures a list into its constituent parts.
///
/// If the given list is empty, this function returns .Nil.  If the list is non-empty, this
/// function returns .Cons(head, tail)
public func match<T>(l : [T]) -> ArrayMatcher<T> {
    if l.count == 0 {
        return .Nil
    } else if l.count == 1 {
        return .Cons(l[0], [])
    }
    let hd = l[0]
    let tl = Array<T>(l[1..<l.count])
    return .Cons(hd, tl)
}

/// Returns the first element in the list, or None if the list is empty.
public func head<A>(l : [A]) -> Optional<A> {
    switch match(l) {
    case .Nil:
        return .None
    case .Cons(let x, _):
        return .Some(x)
    }
}

/// Returns the tail of the list, or None if the list is empty.
public func tail<A>(l : [A]) -> Optional<[A]> {
    switch match(l) {
    case .Nil:
        return .None
    case .Cons(_, let xs):
        return .Some(xs)
    }
}

/// Takes, at most, a specified number of elements from a list and returns that sublist.
///
///     take(3,  from: [1,2]) == [1,2]
///     take(-1, from: [1,2]) == []
///     take(0,  from: [1,2]) == []
public func take<A>(n : Int, from list : [A]) -> [A] {
    if n <= 0 {
        return []
    }
    
    return Array(list[0 ..< min(n, list.count)])
}

/// Drops, at most, a specified number of elements from a list and returns that sublist.
///
///     drop(3,  from: [1,2]) == []
///     drop(-1, from: [1,2]) == [1,2]
///     drop(0,  from: [1,2]) == [1,2]
public func drop<A>(n : Int, from list : [A]) -> [A] {
    if n <= 0 {
        return list
    }
    
    return Array(list[min(n, list.count) ..< list.count])
}

/// Adds an element to the front of a list.
public func cons<T>(lhs : T, var rhs : [T]) -> [T] {
    rhs.insert(lhs, atIndex: 0)
    return rhs
}

/// Safely indexes into an array by converting out of bounds errors to nils.
public func safeIndex<T>(array : Array<T>)(i : Int) -> T? {
    return indexArray(array, i)
}

/// Returns the result of concatenating the values in the left and right arrays together.
public func concat<T>(lhs: [T])(_ rhs : [T]) -> [T] {
    return lhs + rhs
}

/// Maps a function over an array that takes pairs of (index, element) to a different element.
public func mapWithIndex<T, U>(array : Array<T>)(f : (Int, T) -> U) -> [U] {
    var res = [U]()
    res.reserveCapacity(array.count)
    for i in 0 ..< array.count {
        res.append(f(i, array[i]))
    }
    return res
}

/// Folds a reducing function over an array from right to left.
public func foldRight<T, U>(array : Array<T>)(z : U, f : (T, U) -> U) -> U {
    var res = z
    for x in array {
        res = f(x, res)
    }
    return res
}

//zip takes two lists and returns a list of corresponding pairs. If one input list is short,
//excess elements of the longer list are discarded.
public func zip<A,B>(fst:[A], scd:[B]) -> Array<(A,B)> {
    var size = min(fst.count, scd.count)
    var newArr = Array<(A,B)>()
    for x in 0..<size {
        newArr += [(fst[x], scd[x])]
    }
    return newArr
}

//zip3 takes three lists and returns a list of triples, analogous to zip.
public func zip3<A,B,C>(fst:[A], scd:[B], thrd:[C]) -> Array<(A,B,C)> {
    var size = min(fst.count, scd.count, thrd.count)
    var newArr = Array<(A,B,C)>()
    for x in 0..<size {
        newArr += [(fst[x], scd[x], thrd[x])]
    }
    return newArr
}

//zipWith generalises zip by zipping with the function given as the first argument,
//instead of a tupling function.
//For example, zipWith (+) is applied to two lists to produce the list of corresponding sums.
public func zipWith<A,B,C>(fst:[A], scd:[B], f:((A, B) -> C)) -> Array<C> {
    var size = min(fst.count, scd.count)
    var newArr = [C]()
    for x in 0..<size {
        newArr += [f(fst[x], scd[x])]
    }
    return newArr
}

//The zipWith3 function takes a function which combines three elements, as well as three lists
//and returns a list of their point-wise combination, analogous to zipWith.
public func zipWith3<A,B,C,D>(fst:[A], scd:[B], thrd:[C], f:((A, B, C) -> D)) -> Array<D> {
    var size = min(fst.count, scd.count, thrd.count)
    var newArr = [D]()
    for x in 0..<size {
        newArr += [f(fst[x], scd[x], thrd[x])]
    }
    return newArr
}

/// Takes a binary function, an initial value, and a list and scans the function across each element
/// of a list accumulating the results of successive function calls applied to reduced values from
/// the left to the right.
///
///     scanl(z, [x1, x2, ...], f) == [z, f(z, x1), f(f(z, x1), x2), ...]
public func scanl<B, T>(start : B, list : [T], r : (B, T) -> B) -> [B] {
    if list.isEmpty {
        return [start]
    }
    var arr = [B]()
    arr.append(start)
    var reduced = start
    for x in list {
        reduced = r(reduced, x)
        arr.append(reduced)
    }
    return Array(arr)
}

/// Returns the first element in a list matching a given predicate.  If no such element exists, this
/// function returns nil.
public func find<T>(list : [T], f : (T -> Bool)) -> T? {
    for x in list {
        if f(x) {
            return .Some(x)
        }
    }
    return .None
}

/// Returns a tuple containing the first n elements of a list first and the remaining elements
/// second.
///
///     splitAt(3, [1,2,3,4,5]) == ([1,2,3],[4,5])
///     splitAt(1, [1,2,3])     == ([1],[2,3])
///     splitAt(3, [1,2,3])     == ([1,2,3],[])
///     splitAt(4, [1,2,3])     == ([1,2,3],[])
///     splitAt(0, [1,2,3])     == ([],[1,2,3])
public func splitAt<T>(n : Int, list : [T]) -> ([T], [T]) {
    return (take(n, from: list), drop(n, from: list))
}

/// Takes a separator and a list and intersperses that element throughout the list.
///
///     intersperse(",", ["a","b","c","d","e"] == ["a",",","b",",","c",",","d",",","e"]
public func intersperse<T>(item : T, list : [T]) -> [T] {
    func prependAll(item:T, array:[T]) -> [T] {
        var arr = Array([item])
        for i in 0..<(array.count - 1) {
            arr.append(array[i])
            arr.append(item)
        }
        arr.append(array[array.count - 1])
        return arr
    }
    if list.isEmpty {
        return list
    } else if list.count == 1 {
        return list
    } else {
        var array = Array([list[0]])
        array += prependAll(item, tail(list)!)
        return Array(array)
    }
}


/// Maps a function over a list of Optionals, applying the function of the optional is Some,
/// discarding the value if it is None and returning a list of non Optional values
public func mapFlatten<A>(xs : [A?]) -> [A] {
    var w = [A]()
    w.reserveCapacity(foldRight(xs)(z: 0) { c, n in
        if c != nil {
            return n + 1
        } else {
            return n
        }
        })
    for c in xs {
        if let x = c {
            w.append(x)
        } else {
            // nothing
        }
    }
    return w
}

/// Safely indexes into an array by converting out of bounds errors to nils.
public func indexArray<A>(xs : [A], i : Int) -> A? {
    if i < xs.count && i >= 0 {
        return xs[i]
    } else {
        return nil
    }
}

/// Returns the conjunction of a list of Booleans.
public func and(list : [Bool]) -> Bool {
    return list.reduce(true) {$0 && $1}
}

/// Returns the dijunction of a list of Booleans.
public func or(list : [Bool]) -> Bool {
    return list.reduce(false) {$0 || $1}
}

/// Maps a predicate over a list.  For the result to be true, the predicate must be satisfied at
/// least once by an element of the list.
public func any<A>(list : [A], f : (A -> Bool)) -> Bool {
    return or(list.map(f))
}

/// Maps a predicate over a list.  For the result to be true, the predicate must be satisfied by
/// all elemenets of the list.
public func all<A>(list : [A], f : (A -> Bool)) -> Bool {
    return and(list.map(f))
}

/// Concatenate a list of lists.
public func concat<A>(list : [[A]]) -> [A] {
    return list.reduce([]) { (start, l) -> [A] in
        return concat(start)(l)
    }
}

///Map a function over a list and concatenate the results.
public func concatMap<A,B>(list: [A], f: A -> [B]) -> [B] {
    return list.reduce([]) { (start, l) -> [B] in
        return concat(start)(f(l))
    }
}


/// Inserts a list in between the elements of a 2-dimensional array and concatenates the result.
public func intercalate<A>(list : [A], nested : [[A]]) -> [A] {
    return concat(intersperse(list, nested))
}


/// Returns a tuple with the first elements that satisfy a predicate until that predicate returns
/// false first, and a the rest of the elements second.
///
///     span([1, 2, 3, 4, 1, 2, 3, 4]) { <3 } == ([1, 2],[3, 4, 1, 2, 3, 4])
///     span([1, 2, 3]) { <9 }                == ([1, 2, 3],[])
///     span([1, 2, 3]) { <0 }                == ([],[1, 2, 3])
///
///     span(list, p) == (takeWhile(list, p), dropWhile(list, p))
public func span<A>(list : [A], p : (A -> Bool)) -> ([A], [A]) {
    switch match(list) {
    case .Nil:
        return ([], [])
    case .Cons(let x, let xs):
        if p(x) {
            let (ys, zs) = span(xs, p)
            return (cons(x, ys), zs)
        }
        return ([], list)
    }
}

/// Takes a list and groups its arguments into sublists of duplicate elements found next to each
/// other according to an equality predicate.
public func groupBy<A>(list : [A], p : A -> A -> Bool) -> [[A]] {
    switch match(list) {
    case .Nil:
        return []
    case .Cons(let x, let xs):
        let (ys, zs) = span(xs, p(x))
        let l = cons(x, ys)
        return cons(l, groupBy(zs, p))
    }
}


/// Takes a list and groups its arguments into sublists of duplicate elements found next to each
/// other.
///
///     group([0, 1, 1, 2, 3, 3, 4, 5, 6, 7, 7]) == [[0], [1, 1], [2], [3, 3], [4], [5], [6], [7, 7]]
public func group<A : Equatable>(list : [A]) -> [[A]] {
    return groupBy(list, { a in { b in a == b } })
}

/// Returns a list of the first elements that do not satisfy a predicate until that predicate
/// returns false.
///
///     dropWhile([1, 2, 3, 4, 5, 1, 2, 3], <3) == [3,4,5,1,2,3]
///     dropWhile([1, 2, 3], <9)                == []
///     dropWhile([1, 2, 3], <0)                == [1,2,3]
public func dropWhile<A>(list : [A], p : A -> Bool) -> [A] {
    switch match(list) {
    case .Nil:
        return []
    case .Cons(let x, let xs):
        if p(x) {
            return dropWhile(xs, p)
        }
        return list
    }
}

/// Returns a list of the first elements that satisfy a predicate until that predicate returns
/// false.
///
///     takeWhile([1, 2, 3, 4, 1, 2, 3, 4], <3)  == [1, 2]
///     takeWhile([1,2,3], <9)                  == [1, 2, 3]
///     takeWhile([1,2,3], <0)                  == []
public func takeWhile<A>(list : [A], p : A -> Bool) -> [A] {
    switch match(list) {
    case .Nil:
        return []
    case .Cons(let x, let xs):
        if p(x) {
            return cons(x, takeWhile(xs, p))
        }
        return []
    }
}