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

struct ArgsDynamicPart {
    let Item: ByteType
}

struct SemanticLengthConsumerDynamicPart {
    
}
