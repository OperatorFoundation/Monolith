import Foundation

struct Instance
{
    var Desc: Description
    var Args: Args
}

extension Instance
{
    mutating func Messages() -> [Message]
    {
        let context = NewEmptyContext()
        let messages = self.Desc.MessagesFromArgs(args: self.Args, context: context)
        var result: [Message] = []

        for message in messages
        {
            result.append(message)
        }
        return result
    }
}

extension Description
{
    mutating func MessagesFromArgs(args: Args, context: Context) -> [Message]
    {
        var result: [Message] = []
        
        for part in self.Parts
        {
            guard let m = part.MessageFromArgs(args: args, context: context) else
            {
                continue
            }
            
            result.append(m)
        }
        
        return result
    }
}

extension BytesPart: Messageable
{
    public func MessageFromArgs(args: Args, context: Context) -> Message? {
        var result: [UInt8] = []
        var inoutArgs = args
        var inoutContext = context
        for item in self.Items {
            let (maybeB, maybeError) = item.ByteFromArgs(args: &inoutArgs, context: &inoutContext)
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

extension MonolithConfig: Messageable
{
    public func MessageFromArgs(args: Args, context: Context) -> Message?
    {
        switch self
        {
            case .bytes(let bytesPart):
                return bytesPart.MessageFromArgs(args: args, context: context)
        }
    }
}

extension FixedByteType: ByteFromArgsable {
    public func ByteFromArgs(args _: inout Args, context _: inout Context) -> (UInt8?, Error?) {
        return (self.Byte, nil)
    }
}

enum EnumeratedByteTypeError: Error {
    case popError
    case enumerationError
}

extension EnumeratedByteType: ByteFromArgsable {
    public func ByteFromArgs(args: inout Args, context _: inout Context) -> (UInt8?, Error?) {
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

extension RandomByteType: ByteFromArgsable {
    public func ByteFromArgs(args _: inout Args, context _: inout Context) -> (UInt8?, Error?) {
        return (UInt8.random(in: 0...255), nil)
    }
}

extension RandomEnumeratedByteType: ByteFromArgsable {
    public func ByteFromArgs(args _: inout Args, context _: inout Context) -> (UInt8?, Error?) {
        return (self.RandomOptions.randomElement(), nil)
    }
}
