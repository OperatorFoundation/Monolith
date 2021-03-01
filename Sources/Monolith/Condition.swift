//
//  File.swift
//  
//
//  Created by Joshua Clark on 3/1/21.
//

import Foundation

protocol Condition {
    func Evaluate(value: Any) -> Bool
}

struct EqualsCondition {
    self: Ant
}
