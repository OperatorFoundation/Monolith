//
//  Count.swift
//  Monolith
//
//  Created by Mafalda on 7/20/20.
//

import Foundation

protocol Countable {
    func Count() -> Int
}

extension BytesPart {
    func Count() -> Int {
        var result = 0
        
        // FIXME: how do i do that go sequence in swift?
        for (index = 0) {
            
        }
    }
}

extension FixedByType {
    func Count() -> Int {
        return 1
    }
}

extension EnumeratedByteType {
    func Count() -> Int {
        return 1
    }
}

extension RandomByteType {
    func Count() -> Int {
        return 1
    }
}

extension RandomEnumeratedByteType {
    func Count() -> Int {
        return 1
    }
}

extension TimedPart {
    
}
