//
//  Utils.swift
//  SwiftLand
//
//  Created by Alexander on 8/27/15.
//  Copyright (c) 2015 Alexander Karaberov. All rights reserved.
//

import Foundation


//Method to validate input email address
public func isValidEmail(email: String) -> Bool {
    
    let emailRegExp: String = "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}" +
                              "[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"
    
    let emailTestPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegExp)
    return emailTestPredicate.evaluateWithObject(email)
}

//This function is an analogue of the handy macro NSDictionaryOfVariableBindings from Objective-C
//but instead of view names you should use ordinal numeration: view1, view2... viewN.
public func dictionaryOfVariableBindings(variables: UIView...) -> Dictionary<String, UIView> {
    
    var dictionary = Dictionary<String, UIView>()
    
    map(enumerate(variables)) { (index, element) in
        dictionary["view\(index + 1)"] = element
    }
    return dictionary
}
