//
//  Operators.swift
//  SwiftLand
//
//  Created by Alexander on 8/28/15.
//  Copyright (c) 2015 Alexander Karaberov. All rights reserved.
//

import Foundation


/// Pipe Backward | Applies the function to its left to an argument on its right.
infix operator <| {
associativity right
precedence 0
}

/// Pipe forward | Applies an argument on the left to a function on the right.
infix operator |> {
associativity left
precedence 0
}

/// MARK: Data.Monoid

/// Append | Alias for a Semigroup's operation.
infix operator <> {
associativity right
precedence 160
}

/// MARK: Control.*

/// Fmap | Maps a function over the value encapsulated by a functor.
infix operator <^> {
associativity left
precedence 140
}

/// Ap | Applies a function encapsulated by a functor to the value encapsulated by another functor.
infix operator <*> {
associativity left
precedence 140
}

/// Bind | Sequences and composes two monadic actions by passing the value inside the monad on the
/// left to a function on the right yielding a new monad.
infix operator >>- {
associativity left
precedence 110
}

/// Extend | Duplicates the surrounding context and computes a value from it while remaining in the
/// original context.
infix operator ->> {
associativity left
precedence 110
}


/// MARK: Control.Arrow

/// Split | Splits two computations and combines the result into one Arrow yielding a tuple of
/// the result of each side.
infix operator *** {
precedence 130
associativity right
}

/// Fanout | Given two functions with the same source but different targets, this function
/// splits the computation and combines the result of each Arrow into a tuple of the result of
/// each side.
infix operator &&& {
precedence 130
associativity right
}

/// MARK: Control.Arrow.Choice

/// Splat | Splits two computations and combines the results into Eithers on the left and right.
infix operator +++ {
precedence 120
associativity right
}

/// Fanin | Given two functions with the same target but different sources, this function splits
/// the input between the two and merges the output.
infix operator ||| {
precedence 120
associativity right
}

/// MARK: Control.Arrow.Plus

/// Op | Combines two ArrowZero monoids.
infix operator <+> {
precedence 150
associativity right
}

/// MARK: Data.JSON

/// Retrieve | Retrieves a value from a dictionary of JSON values using a given keypath.
///
/// If the given keypath is not present or the retrieved value is not of the appropriate type, this
/// function returns `.None`.
infix operator <? {
precedence 150
associativity left
}

/// Force Retrieve | Retrieves a value from a dictionary of JSON values using a given keypath,
/// forcing any Optionals it finds.
///
/// If the given keypath is not present or the retrieved value is not of the appropriate type, this
/// function will terminate with a fatal error.  It is recommended that you use Force Retrieve's
/// total cousin `<?` (Retrieve).
infix operator <! {
precedence 150
associativity left
}

/// MARK: Data.Result

/// From | Creates a Result given a function that can possibly fail with an error.
infix operator !! {
associativity none
precedence 120
}

/// MARK: Data.Chan

/// Write | Writes a value into a channel.
infix operator  <- {}

/// Read | Reads a value from a channel.
prefix operator <- {}

/// MARK: Data.Set

/// Intersection | Returns the intersection of two sets.
infix operator ∩ {}

/// Union | Returns the union of two sets.
infix operator ∪ {}

/// MARK: Sections

prefix operator • {}
postfix operator • {}

prefix operator § {}
postfix operator § {}

prefix operator |> {}
postfix operator |> {}

prefix operator <| {}
postfix operator <| {}

// "fmap" like
prefix operator <^> {}
postfix operator <^> {}

// "imap" like
prefix operator <^^> {}
postfix operator <^^> {}

// "contramap" like
prefix operator <!> {}
postfix operator <!> {}

// "ap" like
prefix operator <*> {}
postfix operator <*> {}

// "extend" like
prefix operator ->> {}
postfix operator ->> {}

/// Monadic bind
prefix operator >>- {}
postfix operator >>- {}
