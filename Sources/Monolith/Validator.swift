//
//  Validator.swift
//  Monolith
//
//  Created by Mafalda on 7/20/20.
//

import Foundation

public class Validity {
    var validity: Int
    public init(validity: Int) {
        self.validity = validity
    }
}

enum validity {
    // Iota?
    case Valid
    case Invalid
    case Incomplete
}

public protocol Validateable {
    func Validate(buffer: Buffer, context: Context) -> Validity
}
