//
//  ArrayExtensions.swift
//  SwiftLand
//
//  Created by Alexander on 8/26/15.
//  Copyright (c) 2015 Alexander Karaberov. All rights reserved.
//

import Foundation

public enum ArrayMatcher<A> {
    case Nil
    case Cons(A, [A])
}

extension Array {
    
    /// Destructures a list into its constituent parts.
    ///
    /// If the given list is empty, this function returns .Nil.  If the list is non-empty, this
    /// function returns .Cons(head, tail)
    public var match : ArrayMatcher<Element> {
        if self.count == 0 {
            return .Nil
        } else if self.count == 1 {
            return .Cons(self[0], [])
        }
        let hd = self[0]
        let tl = Array(self[1..<self.count])
        return .Cons(hd, tl)
    }
    
    /// Checks if array is empty. If it is, it returns true, otherwise it returns false
    public var null : Bool {
        switch self.match {
        case .Nil:
            return true
        case .Cons(_, _):
            return false
        }
    }
    
    /// Returns the tail of the list, or None if the list is empty.
    ///To take head of the array use array.first.
    public var tail : Optional<[Element]> {
        switch self.match {
        case .Nil:
            return .None
        case .Cons(_, let xs):
            return .Some(xs)
        }
    }
    
    /// Takes, at most, a specified number of elements from a list and returns that sublist.
    ///
    ///     [1,2].take(3)  == [1,2]
    ///     [1,2].take(-1) == []
    ///     [1,2].take(0)  == []
    public func take(n : Int) -> [Element] {
        if n <= 0 {
            return []
        }
        
        return Array(self[0 ..< min(n, self.count)])
    }
    
    /// Drops, at most, a specified number of elements from a list and returns that sublist.
    ///
    ///     [1,2].drop(3)  == []
    ///     [1,2].drop(-1) == [1,2]
    ///     [1,2].drop(0)  == [1,2]
    public func drop(n : Int) -> [Element] {
        if n <= 0 {
            return self
        }
        
        return Array(self[min(n, self.count) ..< self.count])
    }
    
    /// Returns an array consisting of the receiver with a given element appended to the front.
    public func cons(lhs : Element) -> [Element] {
        return [lhs] + self
    }
    
    /// Decomposes the receiver into its head and tail.  If the receiver is empty the result is
    /// `.None`, else the result is `.Just(head, tail)`.
    public var uncons : Optional<(Element, [Element])> {
        switch self.match {
        case .Nil:
            return .None
        case let .Cons(x, xs):
            return .Some(x, xs)
        }
    }
    
    /// Safely indexes into an array by converting out of bounds errors to nils.
    public func safeIndex(i : Int) -> Element? {
        if i < self.count && i >= 0 {
            return self[i]
        } else {
            return nil
        }
    }
    
    ///Maps a function over an array that takes pairs of (index, element) to a different element.
    ///See here: http://stackoverflow.com/questions/28012205/map-or-reduce-with-index-in-swift/33397337#33397337
    ///Also here: http://stackoverflow.com/questions/16191824/index-of-element-in-list-in-haskell
    public func mapWithIndex<U>(f : (Int, Element) -> U) -> [U] {
        return zip((self.startIndex ..< self.endIndex), self).map(f)
    }

    /// Maps list of Optional to list of values
    public func mapMaybe<U>(f : Element -> Optional<U>) -> [U] {
        var res = [U]()
        res.reserveCapacity(self.count)
        self.forEach { x in
            if let v = f(x) {
                res.append(v)
            }
        }
        return res
    }
    
    /// Folds a reducing function over an array from right to left.
    public func foldRight<U>(z : U, f : (Element, U) -> U) -> U {
        var res = z
        for x in self {
            res = f(x, res)
        }
        return res
    }
    
    /// Takes a binary function, an initial value, and a list and scans the function across each
    /// element from left to right.  After each pass of the scanning function the output is added to
    /// an accumulator and used in the succeeding scan until the receiver is consumed.
    ///
    ///     [x1, x2, ...].scanl(z, f) == [z, f(z, x1), f(f(z, x1), x2), ...]
    public func scanl<B>(start : B, r : (B, Element) -> B) -> [B] {
        if self.isEmpty {
            return [start]
        }
        var arr = [B]()
        arr.append(start)
        var reduced = start
        for x in self {
            reduced = r(reduced, x)
            arr.append(reduced)
        }
        return arr
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
    ///     [1,2,3,4,5].splitAt(3) == ([1, 2, 3],[4, 5])
    ///     [1,2,3].splitAt(1)     == ([1], [2, 3])
    ///     [1,2,3].splitAt(3)     == ([1, 2, 3], [])
    ///     [1,2,3].splitAt(4)     == ([1, 2, 3], [])
    ///     [1,2,3].splitAt(0)     == ([], [1, 2, 3])
    public func splitAt(n : Int) -> ([Element], [Element]) {
        return (self.take(n), self.drop(n))
    }
    
    /// Takes a separator and a list and intersperses that element throughout the list.
    ///
    ///     ["a","b","c","d","e"].intersperse(",") == ["a",",","b",",","c",",","d",",","e"]
    public func intersperse(item : Element) -> [Element] {
        func prependAll(item : Element, array : [Element]) -> [Element] {
            var arr = Array([item])
            for i in array.startIndex..<array.endIndex.predecessor() {
                arr.append(array[i])
                arr.append(item)
            }
            arr.append(array[array.endIndex.predecessor()])
            return arr
        }
        
        if self.isEmpty {
            return self
        } else if self.count == 1 {
            return self
        } else {
            var array = Array([self[0]])
            array += prependAll(item, array: self.tail!)
            return Array(array)
        }
    }
    
    /// Returns a tuple where the first element is the longest prefix of elements that satisfy a
    /// given predicate and the second element is the remainder of the list:
    ///
    ///     [1, 2, 3, 4, 1, 2, 3, 4].span(<3) == ([1, 2],[3, 4, 1, 2, 3, 4])
    ///     [1, 2, 3].span(<9)                == ([1, 2, 3],[])
    ///     [1, 2, 3].span(<0)                == ([],[1, 2, 3])
    ///
    ///     span(list, p) == (takeWhile(list, p), dropWhile(list, p))
    public func span(p : Element -> Bool) -> ([Element], [Element]) {
        switch self.match {
        case .Nil:
            return ([], [])
        case .Cons(let x, let xs):
            if p(x) {
                let (ys, zs) = xs.span(p)
                return (ys.cons(x), zs)
            }
            return ([], self)
        }
    }
    
    
    /// Takes a list and groups its arguments into sublists of duplicate elements found next to each
    /// other according to an equality predicate.
    public func groupBy(p : Element -> Element -> Bool) -> [[Element]] {
        switch self.match {
        case .Nil:
            return []
        case .Cons(let x, let xs):
            let (ys, zs) = xs.span(p(x))
            let l = ys.cons(x)
            return zs.groupBy(p).cons(l)
        }
    }
    
    
    /// Returns an array of the first elements that do not satisfy a predicate until that predicate
    /// returns false.
    ///
    ///     [1, 2, 3, 4, 5, 1, 2, 3].dropWhile(<3) == [3,4,5,1,2,3]
    ///     [1, 2, 3].dropWhile(<9)                == []
    ///     [1, 2, 3].dropWhile(<0)                == [1,2,3]
    public func dropWhile(p : Element -> Bool) -> [Element] {
        switch self.match {
        case .Nil:
            return []
        case .Cons(let x, let xs):
            if p(x) {
                return xs.dropWhile(p)
            }
            return self
        }
    }
    
    /// Returns an array of of the remaining elements after dropping the largest suffix of the
    /// receiver over which the predicate holds.
    ///
    ///     [1, 2, 3, 4, 5].dropWhileEnd(>3) == [1, 2, 3]
    ///     [1, 2, 3, 4, 5, 2].dropWhileEnd(>3) == [1, 2, 3, 4, 5, 2]
    public func dropWhileEnd(p : Element -> Bool) -> [Element] {
        return self.reduce([Element](), combine: { xs, x in p(x) && xs.isEmpty ? [] : xs.cons(x) })
    }
    
    /// Returns an array of the first elements that satisfy a predicate until that predicate returns
    /// false.
    ///
    ///     [1, 2, 3, 4, 1, 2, 3, 4].takeWhile(<3) == [1, 2]
    ///     [1,2,3].takeWhile(<9)                  == [1, 2, 3]
    ///     [1,2,3].takeWhile(<0)                  == []
    public func takeWhile(p : Element -> Bool) -> [Element] {
        switch self.match {
        case .Nil:
            return []
        case .Cons(let x, let xs):
            if p(x) {
                return xs.takeWhile(p).cons(x)
            }
            return []
        }
    }
}

extension Array where Element : Equatable {
    
    ///Destructively removes element from the collection
    mutating func removeObject(object : Generator.Element) {
        if let index = self.indexOf(object) {
            self.removeAtIndex(index)
        }
    }
}

extension Array where Element : BooleanType {
    /// Returns the conjunction of a list of Booleans.
    public var and : Bool {
        return self.reduce(true) { $0.boolValue && $1.boolValue }
    }
    
    /// Returns the dijunction of a list of Booleans.
    public var or : Bool {
        return self.reduce(false) { $0.boolValue || $1.boolValue }
    }
}