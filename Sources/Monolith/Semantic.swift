//
//  Semantic.swift
//  Monolith
//
//  Created by Mafalda on 7/20/20.
//

import Foundation

enum SemanticError: Error
{
    case popError
}

public struct SemanticIntProducerByteType: Codable
{
    public let name: String
    public let value: ByteTypeConfig
    
    public init(name: String, value: ByteTypeConfig)
    {
        self.name = name
        self.value = value
    }
}

public struct SemanticIntConsumerByteType: Codable
{
    public let name: String
    
    public init(name: String)
    {
        self.name = name
    }
}
