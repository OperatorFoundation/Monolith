//
//  Dynamic.swift
//  Monolith
//
//  Created by Mafalda on 7/21/20.
//

import Foundation

protocol DynamicPart {
    func Fix(n: Int) -> BytesPart
}

struct ArgsDynamicPart: Codable
{
    let Item: ByteTypeConfig
}

struct SemanticLengthConsumerDynamicPart: Codable
{
    let Name: String
    let Item: ByteTypeConfig
    var Cached: BytesPart?
}

struct SemanticSeedConsumerDynamicPart: Codable
{
    let Name: String
    let Item: ByteTypeConfig
    var Cached: BytesPart?
}

extension ArgsDynamicPart
{
    func Fix(n: Int) -> BytesPart
    {
        let items = Array<ByteTypeConfig>(repeating: self.Item, count: n)
        
        return BytesPart(Items: items)
    }
    
    func MessageFromArgs(args: inout Args, context: inout Context) -> Message?
    {
        if args.isEmpty() {
            return nil
        }
        
        let (maybeN, maybeError) = args.popInt()
        guard (maybeError == nil) else {
            return nil
        }
        
        guard let n = maybeN else {
            return nil
        }
        
        let bp = self.Fix(n: n)
        return bp.MessageFromArgs(args: &args, context: &context)
    }
}

extension SemanticLengthConsumerDynamicPart {
    func Fix(n: Int) -> BytesPart
    {
        let items = Array<ByteTypeConfig>(repeating: self.Item, count: n)
        
        return BytesPart(Items: items)
    }
    
    mutating func Parse(buffer: Buffer, args: inout Args, context: inout Context)
    {
        if buffer.isEmpty() {
            return
        }
        
        let (n, ok) = context.GetInt(name: self.Name)
        if (ok) {
            guard let cached = self.Cached else {
                return
            }
            
            self.Cached = self.Fix(n: n)
            cached.Parse(buffer: buffer, args: &args, context: &context)
        }
    }
    
    mutating func Validate(buffer: Buffer, context: inout Context) -> Validity
    {
        if buffer.isEmpty() {
            return Validity.Invalid
        }
        
        let (n, ok) = context.GetInt(name: self.Name)
        if (ok) {
        
            self.Cached = self.Fix(n: n)
            guard let cached = self.Cached else {
                return .Invalid
            }
            return cached.Validate(buffer: buffer, context: &context)
        }
        else {
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

extension SemanticSeedConsumerDynamicPart
{
    func Fix(seed: Int) -> BytesPart
    {
        var monolithRandomNumberGenerator = MonolithRandomNumberGenerator(seed: UInt64(seed))
        let randomFromSeed = UInt8.random(in: 0...255, using: &monolithRandomNumberGenerator)
        let items = Array<ByteTypeConfig>(repeating: self.Item, count: Int(randomFromSeed))
        
        return BytesPart(Items: items)
    }
    
    mutating func Parse(buffer: Buffer, args: inout Args, context: inout Context)
    {
        if buffer.isEmpty() {
            return
        }
        
        let (seed, ok) = context.GetInt(name: self.Name)
        if (ok)
        {
            guard let cached = self.Cached else {
                return
            }
            
            self.Cached = self.Fix(seed: seed)
            cached.Parse(buffer: buffer, args: &args, context: &context)
        }
    }
    
    mutating func Validate(buffer: Buffer, context: inout Context) -> Validity {
        if buffer.isEmpty() {
            return Validity.Invalid
        }
        
        let (seed, ok) = context.GetInt(name: self.Name)
        if (ok) {
            self.Cached = self.Fix(seed: seed)
            
            guard let cached = self.Cached else {
                return .Invalid
            }
            return cached.Validate(buffer: buffer, context: &context)
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
