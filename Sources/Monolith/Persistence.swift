//
//  Persistence.swift
//  Monolith
//
//  Created by Mafalda on 7/20/20.
//

import Foundation

func InitializeGobRegistry() {
    gob.Register(BytesPart{})
    gob.Register(FixedByteType{})
    gob.Register(RandomByteType{})
    gob.Register(EnumeratedByteType{})
    gob.Register(RandomEnumeratedByteType{})
}

func DecodeInstance(encoded: String) -> (Instance, Error) {
    var instance: Instance
    return instance, nil
}

func DecodeDescription(encoded: String) -> (Description, Error) {
    var description: Description
    return description, nil
}
