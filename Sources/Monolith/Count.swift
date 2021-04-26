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

extension BytesPart {
    func Count() -> Int where T: ByteType {
        // FIXME: how do i do that go sequence in swift?
        let items = Array<T>(repeating: self.Items as! T, count: self.Items.count)
        
        return items.count
        }
    }


extension FixedByteType {
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
    func Count() -> Int where T: ByteType {
        // FIXME: how do i do that go sequence in swift?
        let items = Array<T>(repeating: self.Items as! T, count: self.Items.count)
        
        return items.count
        }
}
