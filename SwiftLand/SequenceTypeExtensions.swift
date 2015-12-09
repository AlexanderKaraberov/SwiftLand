//
//  SequenceTypeExtensions.swift
//  SwiftLand
//
//  Created by Alexander on 12/9/15.
//  Copyright © 2015 Alexander Karaberov. All rights reserved.
//

import Foundation


extension SequenceType {
    /// Maps a predicate over a list.  For the result to be true, the predicate must be satisfied at
    /// least once by an element of the list.
    public func any(f : (Generator.Element -> Bool)) -> Bool {
        return self.map(f).or
    }
    
    /// Maps a predicate over a list.  For the result to be true, the predicate must be satisfied by
    /// all elemenets of the list.
    public func all(f : (Generator.Element -> Bool)) -> Bool {
        return self.map(f).and
    }
}