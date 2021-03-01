//
//  Context.swift
//  Monolith
//
//  Created by Mafalda on 7/20/20.
//

import Foundation

struct Context {
    //This replaces map of strings to interface. Any represents...well... anything
    var values: [String:Any]
}

func NewEmptyContext() -> Context {
    return Context.init(values: [String:Any].init(minimumCapacity: 0))
}

extension Context {
    mutating func Set(name:String, value:Any) {
        self.values[name] = value
    }
    
    mutating func Get(name:String) -> (Any, Bool) {
        guard let value = self.values[name] else {
            return ([], false)
        }
        return (value, true)
    }
    
    mutating func GetInt(name:String) -> (Int, Bool) {
        let (value, ok) = self.Get(name: name)
        guard ok else {
            return (0, false)
        }
        guard let intValue = value as? Int else {
            return (0, false)
        }
        
        return (intValue, true)
    }
}
