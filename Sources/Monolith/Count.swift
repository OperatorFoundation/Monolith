//
//  Count.swift
//  Monolith
//
//  Created by Mafalda on 7/20/20.
//

import Foundation

public protocol Countable
{
    func count() -> Int
}

extension BytesPart: Countable
{
    public func count() -> Int
    {
        return self.items.count
    }
}

extension ByteTypeConfig: Countable
{
    public func count() -> Int
    {
        switch self
        {
            case .fixed(let fixedByteType):
                return fixedByteType.count()
            case .enumerated(let enumeratedByteType):
                return enumeratedByteType.count()
            case .random(let randomByteType):
                return randomByteType.count()
            case .randomEnumerated(let randomEnumeratedByteType):
                return randomEnumeratedByteType.count()
            case .semanticIntConsumer(let semanticIntConsumerByteType):
                return semanticIntConsumerByteType.count()
            case .semanticIntProducer(let semanticIntProducerByteType):
                return  semanticIntProducerByteType.count()
        }
    }
}

extension FixedByteType: Countable
{
    public func count() -> Int
    {
        return 1
    }
}

extension EnumeratedByteType: Countable
{
    public func count() -> Int
    {
        return 1
    }
}

extension RandomByteType: Countable
{
    public func count() -> Int
    {
        return 1
    }
}

extension RandomEnumeratedByteType: Countable
{
    public func count() -> Int
    {
        return 1
    }
}

extension TimedPart: Countable
{
    public func count() -> Int where T: ByteType
    {
        return self.Items.count
    }
}

extension SemanticLengthConsumerDynamicPart: Countable
{
    func count() -> Int
    {
        guard let cached = self.cached else
            { return 0 }
        
        return cached.count()
    }
}

extension SemanticSeedConsumerDynamicPart: Countable
{
    func count() -> Int
    {
        guard let cached = self.cached else
            { return 0 }
        
        return cached.count()
    }
}

extension SemanticIntConsumerOptionalPart: Countable
{
    func count() -> Int
    {
        guard let cached = self.Cached else
            { return 0 }
        
        return cached.count()
    }
}

extension SemanticIntProducerByteType: Countable
{
    public func count() -> Int
    {
        return self.Value.count()
    }
}

extension SemanticIntConsumerByteType: Countable
{
    public func count() -> Int
    {
        return 1
    }
}
