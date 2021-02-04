//
//  Args.swift
//  Monolith
//
//  Created by Mafalda on 7/20/20.
//

import Foundation

struct Args {
    var Values: [Protocol]
    let Index: Int
}

func NewEmptyArgs() -> Args {
    return Args.init(Values: <#T##[Protocol]#>, Index: 0)
}

func NewArgs(values: [Protocol]) -> Args {
    return Args.init(Values: values, Index: 0)
}

extension Args {
    func Empty() -> Bool{
        //self takes the place of the lowercase variable from go 
        return self.Values.count <= 0
    }
    
    mutating func Pop() -> (Protocol, Error) {
        if self.Values.count > 0 {
            var value = self.Values[0]
            var rest = self.Values[1...]
            self.Values = rest
            return value, nil
        } else {
            return nil, Error
        }
    }
    
    mutating func PopInt() -> (Int, Error) {
        var value = self.Pop()
        return value.toInt()
    }
    
    mutating func PopByte() -> (Byte, Error) {
        var value = self.Pop()
        if value = Int {
            return value.toByte, nil
        } else {
            return value, nil
        }
    }
    
    func Push(value: Protocol) {
        self.Values = append(self.Values, value)
    }
}
