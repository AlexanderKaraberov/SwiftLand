//
//  TupleExtensions.swift
//  SwiftLand
//
//  Created by Alexander on 8/26/15.
//  Copyright (c) 2015 Alexander Karaberov. All rights reserved.
//

import Foundation

//Compare two-tuples (pairs)

func == <T:Equatable> (t1:(T,T),t2:(T,T)) -> Bool
{
    return (t1.0 == t2.0) && (t1.1 == t2.1)
}