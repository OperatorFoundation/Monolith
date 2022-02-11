//
//  Buffer.swift
//  Monolith
//
//  Created by Mafalda on 7/20/20.
//

import Foundation

public class Buffer: Codable
{
    public var value: [UInt8]
    
    public init()
    {
        self.value = [UInt8]()
    }
    
    public init(value: [UInt8])
    {
        self.value = value
    }
    
    func isEmpty() -> Bool
    {
        return self.value.isEmpty
    }
    
    /// Removes the first element from the value array
    public func pop() -> UInt8?
    {
        if (self.value.isEmpty)
        {
            return nil
        }
        
        let first = self.value.removeFirst()
        
        return first
    }
   
    /// Removes the first n elements from the value array
    public func popByte(elementsToRemove: Int) -> ([UInt8], Error?)
    {
        if (self.value.count < elementsToRemove)
        {
            return ([], Error.shortBufferError(elementsToRemove: elementsToRemove))
        }
        
        let removed = [UInt8](self.value[..<elementsToRemove])
        self.value = [UInt8](self.value[elementsToRemove...])
        
        return (removed, nil)
    }
    
    public func push(bytes: [UInt8])
    {
        self.value.append(contentsOf: bytes)
    }
    
    public enum Error: LocalizedError
    {
        case emptyBufferError
        case shortBufferError(elementsToRemove: Int)
        
        public var errorDescription: String?
        {
            switch self {
                case .emptyBufferError:
                    return "The monolith buffer is empty."
                case .shortBufferError(let elementsToRemove):
                    return "The monolith buffer is to short to remove \(elementsToRemove) elements/"
            }
        }
    }
}


