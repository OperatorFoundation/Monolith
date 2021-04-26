import Foundation

struct Instance {
    var Desc: Description
    var Args: Args
}

extension Instance {
    mutating func Messages() -> [Message] {
        let context = NewEmptyContext()
        let ms = self.Desc.MessagesFromArgs(args: self.Args, context: context)
        var result: [Message] = []
        //TODO: the for loop uses range/len , which dont seem to be in swift
        for m in ms {
            result.append(m)
        }
        return result
    }
}

extension Description
{
    mutating func MessagesFromArgs(args: Args, context: Context) -> [Message] {
        var result: [Message] = []
        for part in self.Parts {
            guard let m = part.MessageFromArgs(args: args, context: context) else {
                continue
            }
            result.append(m)
        }
        return result
    }
}

extension BytesPart
{
    func MessageFromArgs(args: Args, context: Context) -> Message {
        var result: [UInt8] = []
        
        for item in self.Items {
           let (maybeB, maybeError) = item.ByteFromArgs(args: args, context: context)
            guard (maybeError == nil) else {
                continue
            }
            guard let b = maybeB else {
                continue
            }
            result.append(b)
        }
        return BytesMessage(bytes: result)
    }
}

extension FixedByteType {
    func ByteFromArgs(_: Args, _: Context) -> (UInt8, Error?) {
        return (self.Byte, nil)
    }
}

enum EnumeratedByteTypeError: Error {
    case popError
    case enumerationError
}

extension EnumeratedByteType {

    func BytefromArgs(args: inout Args, _: inout Context) -> (UInt8, Error?) {
        let (maybeB, maybePopError) = args.PopByte()
        if maybePopError != nil {
            return (0, EnumeratedByteTypeError.popError)
        }
        guard let b = maybeB else {
            return (0, EnumeratedByteTypeError.popError)
        }
        
        if self.Options.contains(b) {
            return (b, nil)
        } else {
            return (0, EnumeratedByteTypeError.enumerationError)
        }
    }
}

extension RandomByteType {
    func ByteFromArgs(_: Args, _: Context) -> (UInt8, Error?) {
        return (UInt8.random(in: 0...255), nil)
    }
}

extension RandomEnumeratedByteType {
    func ByteFromArgs(_: Args, _: Context) -> (UInt8?, Error?) {
        return (self.RandomOptions.randomElement(), nil)
    }
}
