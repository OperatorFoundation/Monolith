//
//  Optional.swift
//  Monolith
//
//  Created by Mafalda on 7/20/20.
//

import Foundation

struct SemanticIntConsumerOptionalPart {
    let Name: String
    let Condition: Condition
    let Item: Monolith
    var Cached: Monolith?
}

extension SemanticIntConsumerOptionalPart {
    func Fix(n: Int) -> Monolith {
        if self.Condition.Evaluate(value: n) {
            return self.Item
        } else {
            return Empty()
        }
    }
    
    mutating func Parse(buffer: Buffer, args: Args, context: inout Context) {
        if buffer.Empty() {
            return
        }
        
        let (n, ok) = context.GetInt(name: self.Name)
        if (ok) {
            self.Cached = self.Fix(n: n)
            self.Cached!.Parse(buffer: buffer, args: args, context: context)
        }
    }
    
    mutating func Validate(buffer: Buffer, context: inout Context) -> Message {
        if buffer.Empty() {
            return Validity.Invalid as! Byteable
        }
        
        let (n, ok) = context.GetInt(name: self.Name)
        if (ok) {
            self.Cached = self.Fix(n: n)
            return self.Cached!.Validate(buffer: buffer, context: context) as! Byteable
        } else {
            return Validity.Invalid as! Byteable
        }
    }
    
    mutating func MessageFromArgs(args: Args, context: inout Context) -> Message? {
        let (n, ok) = context.GetInt(name: self.Name)
        if (ok) {
            self.Cached = self.Fix(n: n)
            return self.Cached!.MessageFromArgs(args: args, context: context)
        } else {
            return nil
        }
    }
    
    func Count() -> Int {
        if self.Cached != nil {
            return self.Cached!.Count()
        } else {
            return 0
        }
    }
}
