//
//  Dynamic.swift
//  Monolith
//
//  Created by Mafalda on 7/21/20.
//

import Foundation

protocol DynamicPart
{
    func fix(count: Int) -> BytesPart
}

struct ArgsDynamicPart: DynamicPart, Codable
{
    let item: ByteTypeConfig
    
    func fix(count: Int) -> BytesPart
    {
        let items = Array<ByteTypeConfig>(repeating: self.item, count: count)
        
        return BytesPart(items: items)
    }
    
    func messageFromArgs(args: inout Args, context: inout Context) -> Message?
    {
        if args.isEmpty() {
            return nil
        }
        
        let (maybeN, maybeError) = args.popInt()
        guard (maybeError == nil) else
            { return nil }
        
        guard let n = maybeN else
            { return nil }
        
        let bytesPart = self.fix(count: n)
        
        return bytesPart.messageFromArgs(args: &args, context: &context)
    }
}

struct SemanticLengthConsumerDynamicPart: DynamicPart, Codable
{
    let name: String
    let item: ByteTypeConfig
    var cached: BytesPart?
    
    func fix(count: Int) -> BytesPart
    {
        let items = Array<ByteTypeConfig>(repeating: self.item, count: count)
        
        return BytesPart(items: items)
    }
    
    mutating func parse(buffer: Buffer, args: inout Args, context: inout Context)
    {
        if buffer.isEmpty()
        {
            return
        }
        
        let (n, ok) = context.getInt(name: self.name)
        if (ok)
        {
            guard let cached = self.cached else
                { return }
            
            self.cached = self.fix(count: n)
            
            cached.Parse(buffer: buffer, args: &args, context: &context)
        }
    }
    
    mutating func validate(buffer: Buffer, context: inout Context) -> Validity
    {
        if buffer.isEmpty()
        {
            return .Invalid
        }
        
        let (n, ok) = context.getInt(name: self.name)
        
        if (ok)
        {
            self.cached = self.fix(count: n)
            
            guard let cached = self.cached else
                { return .Invalid }
            
            return cached.Validate(buffer: buffer, context: &context)
        }
        else
        {
            return .Invalid
        }
    }
    
    mutating func messageFromArgs(args: Args, context: inout Context) -> Message?
    {
        let (n, ok) = context.getInt(name: self.name)
        
        if (ok)
        {
            self.cached = self.fix(count: n)
            return self.messageFromArgs(args: args, context: &context)
        }
        else
        {
            return nil
        }
    }
}

struct SemanticSeedConsumerDynamicPart: DynamicPart, Codable
{
    let name: String
    let item: ByteTypeConfig
    var cached: BytesPart?
    
    func fix(count: Int) -> BytesPart
    {
        var monolithRandomNumberGenerator = MonolithRandomNumberGenerator(seed: UInt64(count))
        let randomFromSeed = UInt8.random(in: 0...255, using: &monolithRandomNumberGenerator)
        let items = Array<ByteTypeConfig>(repeating: self.item, count: Int(randomFromSeed))
        
        return BytesPart(items: items)
    }
    
    mutating func parse(buffer: Buffer, args: inout Args, context: inout Context)
    {
        if buffer.isEmpty() {
            return
        }
        
        let (seed, ok) = context.getInt(name: self.name)
        if (ok)
        {
            guard let cached = self.cached else {
                return
            }
            
            self.cached = self.fix(count: seed)
            cached.Parse(buffer: buffer, args: &args, context: &context)
        }
    }
    
    mutating func validate(buffer: Buffer, context: inout Context) -> Validity
    {
        if buffer.isEmpty()
        {
            return .Invalid
        }
        
        let (seed, ok) = context.getInt(name: self.name)
        if (ok)
        {
            self.cached = self.fix(count: seed)
            
            guard let cached = self.cached else
            { return .Invalid }
            
            return cached.Validate(buffer: buffer, context: &context)
        }
        else
        {
            return .Invalid
        }
    }
    
    mutating func messageFromArgs(args: Args, context: inout Context) -> Message?
    {
        let (seed, ok) = context.getInt(name: self.name)
        
        if (ok)
        {
            self.cached = self.fix(count: seed)
            return self.messageFromArgs(args: args, context: &context)
        }
        else
        {
            return nil
        }
    }
}
