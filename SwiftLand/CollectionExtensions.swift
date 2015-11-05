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

extension Array {
    
    ///Maps a function over an array that takes pairs of (index, element) to a different element.
    ///See here: http://stackoverflow.com/questions/28012205/map-or-reduce-with-index-in-swift/33397337#33397337
    ///Also here: http://stackoverflow.com/questions/16191824/index-of-element-in-list-in-haskell
    public func mapWithIndex<T> (f: (Int, Element) -> T) -> [T] {
        return zip((self.startIndex ..< self.endIndex), self).map(f)
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