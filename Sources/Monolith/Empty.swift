//
//  Empty.swift
//  Monolith
//
//  Created by Mafalda on 7/20/20.
//

import Foundation

struct Empty {

}

extension Empty: Codable {
    
}

extension Empty: Countable {
        
    func Count() -> Int {
        return 0
    }
}

extension Empty: Parseable {
    func Parse(buffer: Buffer, args: inout Args, context: inout Context) {
    }
}

extension Empty: Validateable {
    func Validate(buffer: Buffer, context: inout Context) -> Validity {
        return .Valid
    }
}

extension Empty: Messageable {
    func MessageFromArgs(args: inout Args, context: inout Context) -> Message? {
    return nil
    }
}
