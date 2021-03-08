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

// TODO: Make everything with ByteType in the struct like this
struct ArgsDynamicPart<T> where T: ByteType
{
    let Item: T
}

struct SemanticLengthConsumerDynamicPart {
    let Name: String
    let Item: ByteType
    // TODO: if the struct variable has a pointer, make it var rather than let
    var Cached: BytesPart
}

struct SemanticSeedConsumerDynamicPart {
    let Name: String
    let Item: ByteType
    var Cached: BytesPart
}

// TODO: For functions that use ByteType, make it like this
extension ArgsDynamicPart {
    func Fix(n: Int) -> BytesPart where T: ByteType
    {
        // TODO: repeating makes the go loop redundant
        let items = Array<T>(repeating: self.Item, count: n)
        
        //FIXME: Why curly braces and why don't they work?
        return BytesPart(Items: items)
    }
}
