//
//  Buffer.swift
//  Monolith
//
//  Created by Mafalda on 7/20/20.
//

import Foundation

//If the variable is a pointer, turn it into a class
public class Buffer {
    var value: [UInt8]
    
    public init(value: [UInt8]) {
        self.value = value
    }
}

enum BufferError: Error {
    case emptyBufferError
    case shortBufferError
}

public func NewEmptyBuffer() -> Buffer {
    let value: [UInt8] = []
    return Buffer(value: value)
}

public func NewBuffer(value: [UInt8]) -> Buffer {
    return Buffer(value: value)
}

extension Buffer {
    func Empty() -> Bool{
        return self.value.count == 0
    }
    
    func Pop() -> (UInt8, Error?) {
        if (self.Empty()) {
            return (0, BufferError.emptyBufferError)
        }
        
        var b = self.value[0]
        self.value = [UInt8](self.value[1...])
        
        return (b, nil)
    }
   
    func PopByte(n: Int) -> (UInt8, Error) {
        if (self.value.count < n) {
            
        }
    }
    
    func Push(value: Any) {
        
    }
}
