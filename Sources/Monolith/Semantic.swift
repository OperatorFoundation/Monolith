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
    let name: String
    let value: ByteTypeConfig
}

public struct SemanticIntConsumerByteType: Codable
{
    let name: String
}
