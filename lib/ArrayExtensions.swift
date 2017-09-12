//
//  ArrayExtensions.swift
//  SwiftLand
//
//  Created by Alexander on 8/26/15.
//  Copyright (c) 2015 Alexander Karaberov. All rights reserved.
//

import Foundation

public enum ArrayMatcher<A> {
    case `nil`
    case cons(A, [A])
}

extension Array {
    
    /// Destructures a list into its constituent parts.
    ///
    /// If the given list is empty, this function returns .Nil.  If the list is non-empty, this
    /// function returns .Cons(head, tail)
    public var match : ArrayMatcher<Element> {
        if self.count == 0 {
            return .nil
        } else if self.count == 1 {
            return .cons(self[0], [])
        }
        let hd = self[0]
        let tl = Array(self[1..<self.count])
        return .cons(hd, tl)
    }
    
    /// Checks if array is empty. If it is, it returns true, otherwise it returns false
    public var null : Bool {
        switch self.match {
        case .nil:
            return true
        case .cons(_, _):
            return false
        }
    }
    
    ///Decomposes an array into a tuple containing the head element, and the rest of the array (tail).
    ///If the array is empty, it returns nil
    public var decompose : (head: Element, tail: [Element])? {
        switch self.match {
        case .nil:
            return .none
        case .cons(_, _):
            return (self.first!, Array(self.dropFirst()))
        }
    }
    
    ///Repeatedly applies a function while the condition holds
    public func iterateWhile<A>(_ condition: (A) -> Bool,
                      initialValue: A,
                      next: (A) -> A?) -> A {
        
        if let x = next(initialValue) , condition(x) {
            return iterateWhile(condition, initialValue: x, next: next)
        }
        return initialValue
    }
    
   
    /// Returns an array consisting of the receiver with a given element appended to the front.
    public func cons(_ lhs : Element) -> [Element] {
        return [lhs] + self
    }
    
    
    /// Decomposes the receiver into its head and tail.  If the receiver is empty the result is
    /// `.None`, else the result is `.Just(head, tail)`.
    public var uncons : Optional<(Element, [Element])> {
        switch self.match {
        case .nil:
            return .none
        case let .cons(x, xs):
            return .some((x,xs))
        }
    }
    
    
    /// Safely indexes into an array by converting out of bounds errors to nils.
    public func safeIndex(_ i : Int) -> Element? {
        if i < self.count && i >= 0 {
            return self[i]
        } else {
            return nil
        }
    }
    
    
    ///Maps a function over an array that takes pairs of (index, element) to a different element.
    ///See here: http://stackoverflow.com/questions/28012205/map-or-reduce-with-index-in-swift/33397337#33397337
    ///Also here: http://stackoverflow.com/questions/16191824/index-of-element-in-list-in-haskell
    public func mapWithIndex<U>(_ f : (Int, Element) -> U) -> [U] {
        return zip((self.indices), self).map(f)
    }
    

    /// Maps list of Optional to list of values
    public func mapMaybe<U>(_ f : (Element) -> Optional<U>) -> [U] {
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
    public func foldRight<B>(_ k : (Element) -> (B) -> B, _ i : B) -> B {
        switch self.match {
        case .nil:
            return i
        case .cons(let x, let xs):
            return k(x)(xs.foldRight(k, i))
        }
    }
    
    
    /// Takes a binary function and an array of values, then folds the function over the array from left
    /// to right.  It takes its initial value from the head of the array.
    ///
    /// Because this function draws its initial value from the head of an array, it is non-total with
    /// respect to the empty array.
    public func foldLeft1(_ f: @escaping (Element) -> (Element) -> Element) -> Element {
        switch self.match {
        case .cons(let x, let xs) where xs.count == 0:
            return x
        case .cons(let x, let xs):
            return xs.reduce(x, uncurry(f))
        case .nil:
            fatalError("Cannot invoke foldlLeft1 with an empty array")
        }
    }
    
    
    /// Takes a binary function and an array of values, then folds the function over the array from
    /// right to left.  It takes its initial value from the head of the array.
    ///
    /// Because this function draws its initial value from the head of an array, it is non-total with
    /// respect to the empty array.
    public func foldRight1(_ f: (Element) -> (Element) -> Element) -> Element {
        switch self.match {
        case .cons(let x, let xs) where xs.count == 0:
            return x
        case .cons(let x, let xs):
            return f(x)(xs.foldRight(f,x))
        case .nil:
            fatalError("Cannot invoke foldlRight1 with an empty array")
        }
    }
    
    
    /// Counts how many matches of a predicate occur in the foldable array
    public func filterLength(_ predicate: (Element) -> Bool) -> Int {
        
        return reduce(0, {(a, b) -> Int in (predicate(b) ? 1 : 0) + a })
    }
    
    /// Takes a binary function, an initial value, and a list and scans the function across each
    /// element from left to right.  After each pass of the scanning function the output is added to
    /// an accumulator and used in the succeeding scan until the receiver is consumed.
    ///
    ///     [x1, x2, ...].scanl(z, f) == [z, f(z, x1), f(f(z, x1), x2), ...]
    public func scanl<B>(_ start : B, r : (B, Element) -> B) -> [B] {
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
    public func find<T>(_ list : [T], f : ((T) -> Bool)) -> T? {
        for x in list {
            if f(x) {
                return .some(x)
            }
        }
        return .none
    }
    
    /// Returns a tuple containing the first n elements of a list first and the remaining elements
    /// second.
    ///
    ///     [1,2,3,4,5].splitAt(3) == ([1, 2, 3],[4, 5])
    ///     [1,2,3].splitAt(1)     == ([1], [2, 3])
    ///     [1,2,3].splitAt(3)     == ([1, 2, 3], [])
    ///     [1,2,3].splitAt(4)     == ([1, 2, 3], [])
    ///     [1,2,3].splitAt(0)     == ([], [1, 2, 3])
    public func splitAt(_ n : Int) -> ([Element], [Element]) {
        
        return (Array(self.dropLast(n)),Array(self.dropFirst(n)))
    }
    
    
    /// Takes a separator and a list and intersperses that element throughout the list.
    ///
    ///     ["a","b","c","d","e"].intersperse(",") == ["a",",","b",",","c",",","d",",","e"]
    public func intersperse(_ item : Element) -> [Element] {
        func prependAll(_ item : Element, array : [Element]) -> [Element] {
            var arr = Array([item])
            for i in array.startIndex..<(array.endIndex - 1) {
                arr.append(array[i])
                arr.append(item)
            }
            arr.append(array[(array.endIndex - 1)])
            return arr
        }
        
        if self.isEmpty {
            return self
        } else if self.count == 1 {
            return self
        } else {
            var array = Array([self[0]])
            array += prependAll(item, array: Array(self.dropFirst()))
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
    public func span(_ p : (Element) -> Bool) -> ([Element], [Element]) {
        switch self.match {
        case .nil:
            return ([], [])
        case .cons(let x, let xs):
            if p(x) {
                let (ys, zs) = xs.span(p)
                return (ys.cons(x), zs)
            }
            return ([], self)
        }
    }
    
    
    /// Takes a list and groups its arguments into sublists of duplicate elements found next to each
    /// other according to an equality predicate.
    public func groupBy(_ p : (Element) -> (Element) -> Bool) -> [[Element]] {
        switch self.match {
        case .nil:
            return []
        case .cons(let x, let xs):
            let (ys, zs) = xs.span(p(x))
            let l = ys.cons(x)
            return zs.groupBy(p).cons(l)
        }
    }
    

    /// Returns an array of of the remaining elements after dropping the largest suffix of the
    /// receiver over which the predicate holds.
    ///
    ///     [1, 2, 3, 4, 5].dropWhileEnd(>3) == [1, 2, 3]
    ///     [1, 2, 3, 4, 5, 2].dropWhileEnd(>3) == [1, 2, 3, 4, 5, 2]
    public func dropWhileEnd(_ p : (Element) -> Bool) -> [Element] {
        return self.reduce([Element](), { xs, x in p(x) && xs.isEmpty ? [] : xs.cons(x) })
    }
    
}


///Mutable extensions for destructive array updates
extension Array where Element : Equatable {
    
    ///Destructively removes elements satisfying predicate from the collection
    public mutating func removeBy(_ p: (Element) -> Bool) {
        self.removeObjectsInArray(self.filter {(element) -> Bool in p(element) })
    }
    
    ///Destructively removes element from the collection
    public mutating func removeObject(_ object: Element) {
        if let index = self.index(of: object) {
        
            self.remove(at: index)
        }
    }
    
    ///Destructively removes elements specified in the array parameter from current array
    public mutating func removeObjectsInArray(_ array: [Element]) {
        for object in array {
            self.removeObject(object)
        }
    }
}


extension Array where Element : BinaryInteger {
    
    public func sum() -> Element {
        switch self.match {
        case .nil:
            return 0 as! Element
        case .cons(_, _):
            return self.reduce(0, +)
        }
    }
    
    public func product() -> Element {
        switch self.match {
        case .nil:
            return 1 as! Element
        case .cons(_, _):
            return self.reduce(1, *)
        }
    }
}

