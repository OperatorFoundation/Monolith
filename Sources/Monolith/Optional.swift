//
//  Optional.swift
//  Monolith
//
//  Created by Mafalda on 7/20/20.
//

import Foundation

struct SemanticIntConsumerOptionalPart
{
    let name: String
    let condition: Condition
    let item: Monolith
    var cached: Monolith?

    func fix(n: Int) -> Monolith
    {
        if self.condition.evaluate(value: n)
        {
            return self.item
        }
        else
        {
            return Empty()
        }
    }
    
    mutating func Parse(buffer: Buffer, args: inout Args, context: inout Context)
    {
        if buffer.isEmpty()
        {
            return
        }
        
        let (n, ok) = context.getInt(name: self.name)
        
        if (ok)
        {
            self.cached = self.fix(n: n)
            self.cached!.parse(buffer: buffer, args: &args, context: &context)
        }
    }
    
    mutating func validate(buffer: Buffer, context: inout Context) -> Message
    {
        if buffer.isEmpty()
        {
            return Validity.invalid as! Byteable
        }
        
        let (n, ok) = context.getInt(name: self.name)
        if (ok) {
            self.cached = self.fix(n: n)
            return self.cached!.validate(buffer: buffer, context: &context) as! Byteable
        }
        else {
            return Validity.invalid as! Byteable
        }
    }
    
    mutating func messageFromArgs(args: inout Args, context: inout Context) -> Message?
    {
        let (n, ok) = context.getInt(name: self.name)
        
        if (ok)
        {
            self.cached = self.fix(n: n)
            return self.cached!.messageFromArgs(args: &args, context: &context)
        }
        else
        {
            return nil
        }
    }
}
