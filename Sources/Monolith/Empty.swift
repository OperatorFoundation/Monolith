//
//  Empty.swift
//  Monolith
//
//  Created by Mafalda on 7/20/20.
//

import Foundation

struct Empty {

}

extension Empty {
    func Parse(buffer: Buffer, args: Args, context: Context) {
    }

    func Validate(buffer: Buffer, args: Args, context: Context) -> Validity {
    return self.Valid
    }
    
    func MessageFromArgs(args: Args, context: Context) -> Message {
    return nil
    }
    
    func Count() -> Int {
        return 0
    }
}
