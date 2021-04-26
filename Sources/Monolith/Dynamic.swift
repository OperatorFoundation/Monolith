//
//  Dynamic.swift
//  Monolith
//
//  Created by Mafalda on 7/21/20.
//

import Foundation

protocol DynamicPart {
    func Fix<T>(n: Int) -> BytesPart<T> where T: ByteType
}

// TODO: Make everything with ByteType in the struct like this
struct ArgsDynamicPart<ItemType> where ItemType: ByteType
{
    let Item: ItemType
}

struct SemanticLengthConsumerDynamicPart<ItemType> where ItemType: ByteType {
    let Name: String
    let Item: ItemType
    // TODO: if the struct variable has a pointer, make it var rather than let
    var Cached: BytesPart<ItemType>?
}

struct SemanticSeedConsumerDynamicPart<ItemType> where ItemType: ByteType {
    let Name: String
    let Item: ItemType
    var Cached: BytesPart<ItemType>?
}

// TODO: For functions that use ByteType, make it like this
extension ArgsDynamicPart {
    func Fix(n: Int) -> BytesPart<ItemType>
    {
        // TODO: repeating makes the go loop redundant
        let items = Array<ItemType>(repeating: self.Item, count: n)
        
        //FIXME: Why curly braces and why don't they work?
        return BytesPart(Items: items)
    }
    
    func MessageFromArgs(args: inout Args, context: Context) -> Message? {
        if args.Empty() {
            return nil
        }
        
        let (maybeN, maybeError) = args.PopInt()
        guard (maybeError == nil) else {
            return nil
        }
        
        guard let n = maybeN else {
            return nil
        }
        
        let bp = self.Fix(n: n)
        return bp.MessageFromArgs(args: args, context: context)
    }
}

extension SemanticLengthConsumerDynamicPart {
    func Fix(n: Int) -> BytesPart<ItemType>
    {
        // TODO: repeating makes the go loop redundant
        let items = Array<ItemType>(repeating: self.Item, count: n)
        
        //FIXME: Why curly braces and why don't they work?
        return BytesPart(Items: items)
    }
    
    mutating func Parse(buffer: Buffer, args: Args, context: inout Context) {
        if buffer.Empty() {
            return
        }
        
        let (n, ok) = context.GetInt(name: self.Name)
        if (ok) {
            guard let cached = self.Cached else {
                return
            }
            
            self.Cached = self.Fix(n: n)
            cached.Parse(buffer: buffer, args: args, context: context)
        }
    }
    
    mutating func Validate(buffer: Buffer, context: inout Context) -> Validity {
        if buffer.Empty() {
            return Validity.Invalid
        }
        
        let (n, ok) = context.GetInt(name: self.Name)
        if (ok) {
        
            self.Cached = self.Fix(n: n)
            guard let cached = self.Cached else {
                return .Invalid
            }
            return cached.Validate(buffer: buffer, context: context)
        } else {
            return Validity.Invalid
        }
    }
    
    mutating func MessageFromArgs(args: Args, context: inout Context) -> Message? {
        let (n, ok) = context.GetInt(name: self.Name)
        if (ok) {
            self.Cached = self.Fix(n: n)
            return self.MessageFromArgs(args: args, context: &context)
        } else {
            return nil
        }
    }
    
    mutating func Count() -> Int {
        guard let cached = self.Cached else {
            return 0
        }
        
        return cached.Count()
    }
}

extension SemanticSeedConsumerDynamicPart {
    func Fix(seed: Int) -> BytesPart<ItemType>
    {
        //FIXME: make a pseudorandom number generator that probs doesnt exist in swift :(
        
        // TODO: repeating makes the go loop redundant
        let items = Array<ItemType>(repeating: self.Item, count: seed)
        
        //FIXME: Why curly braces and why don't they work?
        return BytesPart(Items: items)
    }
    
    mutating func Parse(buffer: Buffer, args: Args, context: inout Context) {
        if buffer.Empty() {
            return
        }
        
        let (seed, ok) = context.GetInt(name: self.Name)
        if (ok) {
            guard let cached = self.Cached else {
                return
            }
            self.Cached = self.Fix(seed: seed)
            cached.Parse(buffer: buffer, args: args, context: context)
        }
    }
    
    mutating func Validate(buffer: Buffer, context: inout Context) -> Validity {
        if buffer.Empty() {
            return Validity.Invalid
        }
        
        let (seed, ok) = context.GetInt(name: self.Name)
        if (ok) {
            self.Cached = self.Fix(seed: seed)
            
            guard let cached = self.Cached else {
                return .Invalid
            }
            return cached.Validate(buffer: buffer, context: context)
        } else {
            return Validity.Invalid
        }
    }
    
    mutating func MessageFromArgs(args: Args, context: inout Context) -> Message? {
        let (seed, ok) = context.GetInt(name: self.Name)
        if (ok) {
            self.Cached = self.Fix(seed: seed)
            return self.MessageFromArgs(args: args, context: &context)
        } else {
            return nil
        }
    }
    
    mutating func Count() -> Int {
        guard let cached = self.Cached else {
            return 0
        }
        
        return cached.Count()
    }
}
