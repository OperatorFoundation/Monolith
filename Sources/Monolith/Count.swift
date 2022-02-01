//
//  Count.swift
//  Monolith
//
//  Created by Mafalda on 7/20/20.
//

import Foundation

public protocol Countable {
    func Count() -> Int
}

extension BytesPart: Countable
{
    public func Count() -> Int
    {
        return self.Items.count
    }
}

extension ByteTypeConfig: Countable
{
    public func Count() -> Int
    {
        switch self
        {
            case .fixed(let fixedByteType):
                return fixedByteType.Count()
            case .enumerated(let enumeratedByteType):
                return enumeratedByteType.Count()
            case .random(let randomByteType):
                return randomByteType.Count()
            case .randomEnumerated(let randomEnumeratedByteType):
                return randomEnumeratedByteType.Count()
            case .semanticIntConsumer(let semanticIntConsumerByteType):
                return semanticIntConsumerByteType.Count()
            case .semanticIntProducer(let semanticIntProducerByteType):
                return  semanticIntProducerByteType.Count()
        }
    }
}

extension FixedByteType: Countable {
    public func Count() -> Int {
        return 1
    }
}

extension EnumeratedByteType: Countable {
    public func Count() -> Int {
        return 1
    }
}

extension RandomByteType: Countable {
    public func Count() -> Int {
        return 1
    }
}

extension RandomEnumeratedByteType: Countable {
    public func Count() -> Int {
        return 1
    }
}

extension TimedPart: Countable {
    public func Count() -> Int where T: ByteType {
        // FIXME: how do i do that go sequence in swift?
        let items = Array<T>(repeating: self.Items as! T, count: self.Items.count)
        
        return items.count
    }
}
