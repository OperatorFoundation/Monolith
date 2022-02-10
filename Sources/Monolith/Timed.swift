//
//  Timed.swift
//  Monolith
//
//  Created by Mafalda on 7/20/20.
//

import Foundation

public class TimedPart<T> where T: ByteType
{
    var Milliseconds: UInt
    var Items: [T]
    
    public init(Milliseconds: UInt, Items: [T])
    {
        self.Milliseconds = Milliseconds
        self.Items = Items
    }
}

struct TimedMessage {
    let Milliseconds: UInt
    let bytes: [UInt8]
}

//extension TimedPart: Messageable & Parseable & Validateable {
//    public func MessageFromArgs(args: Args, context: Context) -> Message? {
//        var result: [UInt8] = []
//        var inoutArgs = args
//        var inoutContext = context
//        for item in self.Items {
//            let (maybeB, maybeError) = item.ByteFromArgs(args: &inoutArgs, context: &inoutContext)
//            guard (maybeError == nil) else {
//                continue
//            }
//            guard let b = maybeB else {
//                continue
//            }
//            result.append(b)
//        }
//        return TimedMessage(Milliseconds: self.Milliseconds, bytes: result)
//    }
//    
//    public func Parse(buffer: Buffer, args: Args, context: Context) {
//        for item in self.Items {
//            item.Parse(buffer: buffer, args: args, context: nil)
//        }
//    }
//    
//    public func Validate(buffer: Buffer, context: Context) -> Validity {
//        for item in self.Items {
//            let valid = item.Validate(buffer: buffer, context: nil)
//            switch valid {
//            case .Valid:
//                continue
//            case .Invalid:
//                return .Invalid
//            case .Incomplete:
//                return .Incomplete
//            }
//        }
//        return .Valid
//    }
//    
//}
