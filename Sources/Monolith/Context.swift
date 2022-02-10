//
//  Context.swift
//  Monolith
//
//  Created by Mafalda on 7/20/20.
//

import Foundation

public struct Context
{
    public var values: [String: Any]
    
    public init()
    {
        self.values = [String: Any]()
    }
    
    mutating func set(name: String, value: Any)
    {
        self.values[name] = value
    }
    
    func get(name: String) -> (Any, Bool)
    {
        guard let value = self.values[name] else
            { return ([], false) }
        
        return (value, true)
    }
    
    func getInt(name: String) -> (Int, Bool)
    {
        let (value, intFound) = self.get(name: name)
        
        guard intFound else
            { return (0, false) }
        
        guard let intValue = value as? Int else
            { return (0, false) }
        
        return (intValue, true)
    }
}
