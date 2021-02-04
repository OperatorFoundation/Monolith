//
//  Buffer.swift
//  Monolith
//
//  Created by Mafalda on 7/20/20.
//

import Foundation

//If the variable is a pointer, turn it into a class
public class Buffer {
    var value: [Byte]
    
    public init() {
        value = []
    }
}

public func NewEmptyBuffer() -> Buffer {
    value = make([Byte], 0)
    return Buffer{value:value}
}

public func NewBuffer(value: [Byte]) -> Buffer {
    return Buffer{value:value}
}

extension Buffer {
    func Empty() -> Bool{
        return self.value.count == 0
    }
    
    func Pop() -> (Byte, Error) {
        if (self.Empty()) {
            return 0, Error
        }
        
        var b = self.value[0]
        self.value = self.value[1...]
        
        return b, nil
    }
   
    func PopByte(n: Int) -> (Byte, Error) {
        if (self.value.count < n)
    }
    
    func Push(value: Protocol) {
        
    }
}
