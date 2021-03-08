//
//  Validator.swift
//  Monolith
//
//  Created by Mafalda on 7/20/20.
//

import Foundation

public enum Validity: String {
    case Valid
    case Invalid
    case Incomplete
}

extension Validity {
    // FIXME: I don't know where to start
    func String() -> String {
        return self.rawValue
    }
}

public protocol Validateable {
    //FIXME: uses an internal type?
    func Validate(buffer: Buffer, context: Context) -> Validity
}
