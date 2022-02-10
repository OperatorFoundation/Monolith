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
        
    func count() -> Int {
        return 0
    }
}

extension Empty: Parseable {
    func parse(buffer: Buffer, args: inout Args, context: inout Context) {
    }
}

extension Empty: Validateable {
    func validate(buffer: Buffer, context: inout Context) -> Validity {
        return .valid
    }
}

extension Empty: Messageable {
    func messageFromArgs(args: inout Args, context: inout Context) -> Message? {
    return nil
    }
}
