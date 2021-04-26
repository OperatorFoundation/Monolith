//
//  Empty.swift
//  Monolith
//
//  Created by Mafalda on 7/20/20.
//

import Foundation

struct Empty {

}

extension Empty: Countable {
        
    func Count() -> Int {
        return 0
    }
}

extension Empty: Parseable {
    func Parse(buffer: Buffer, args: Args, context: Context) {
    }
}
extension Empty: Validateable {
    func Validate(buffer: Buffer, context: Context) -> Validity {
        return .Valid
    }
}
extension Empty: Messageable {
    func MessageFromArgs(args: Args, context: Context) -> Message? {
    return nil
    }
}
