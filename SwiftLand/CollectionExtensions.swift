//
//  CollectionExtensions.swift
//  SwiftLand
//
//  Created by Alexander on 11/5/15.
//  Copyright © 2015 Alexander Karaberov. All rights reserved.
//

import Foundation


extension RangeReplaceableCollectionType where Self.Generator.Element: Hashable {
    
    /// Returns collection containing only unique elements of the receiver
    func uniq() -> Self {
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
