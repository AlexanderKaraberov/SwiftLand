//
//  CollectionExtensions.swift
//  SwiftLand
//
//  Created by Alexander on 11/5/15.
//  Copyright © 2015 Alexander Karaberov. All rights reserved.
//

import Foundation


extension RangeReplaceableCollectionType where Generator.Element : Equatable {
    
    ///Destructively removes Equatable element from the collection
    mutating func removeObject(object : Generator.Element) {
        if let index = self.indexOf(object) {
            self.removeAtIndex(index)
        }
    }
    
}

///Implementation of uniq function for Hashable instatnces
extension RangeReplaceableCollectionType where Self.Generator.Element: Hashable {
    
    /// @return the unique elements of the collection
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

///Alternative global uniq function
func uniq<S : SequenceType, T : Hashable where S.Generator.Element == T>(source: S) -> [T] {
    
    var buffer = [T]()
    var added = Set<T>()
    for element in source {
        if !added.contains(element) {
            buffer.append(element)
            added.insert(element)
        }
    }
    return buffer
    
}