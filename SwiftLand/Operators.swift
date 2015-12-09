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

prefix operator <| {}
postfix operator <| {}

