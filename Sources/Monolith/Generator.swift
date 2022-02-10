import Foundation

public struct Instance: Codable
{
    var description: Description
    var args: Args
    
    public mutating func messages() -> [Message]
    {
        var context = Context()
        let messages = self.description.MessagesFromArgs(args: &self.args, context: &context)
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
    mutating func MessagesFromArgs(args: inout Args, context: inout Context) -> [Message]
    {
        var result: [Message] = []
        
        for part in self.parts
        {
            guard let m = part.messageFromArgs(args: &args, context: &context) else
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
    public func messageFromArgs(args: inout Args, context: inout Context) -> Message?
    {
        var result: [UInt8] = []
        
        for item in self.items
        {
            let (maybeB, maybeError) = item.byteFromArgs(args: &args, context: &context)
            
            guard (maybeError == nil) else
                { continue }
            
            guard let b = maybeB else
                { continue }
            
            result.append(b)
        }
        
        return BytesMessage(messageBytes: result)
    }
}

extension MonolithConfig: Messageable
{
    public func messageFromArgs(args: inout Args, context: inout Context) -> Message?
    {
        switch self
        {
            case .bytes(let bytesPart):
                return bytesPart.messageFromArgs(args: &args, context: &context)
        }
    }
}

extension FixedByteType: ByteFromArgsable
{
    public func byteFromArgs(args _: inout Args, context _: inout Context) -> (UInt8?, Error?)
    {
        return (self.byte, nil)
    }
}

extension EnumeratedByteType: ByteFromArgsable
{
    public func byteFromArgs(args: inout Args, context: inout Context) -> (UInt8?, Error?)
    {
        let (maybeB, maybePopError) = args.popByte()
        
        if maybePopError != nil
        {
            return (0, EnumeratedByteTypeError.popError)
        }
        
        guard let b = maybeB else
            { return (0, EnumeratedByteTypeError.popError) }
        
        if self.options.contains(b)
        {
            return (b, nil)
        }
        else
        {
            return (0, EnumeratedByteTypeError.enumerationError)
        }
    }
    
    public enum EnumeratedByteTypeError: Error
    {
        case popError
        case enumerationError
    }
}

extension RandomByteType: ByteFromArgsable
{
    public func byteFromArgs(args _: inout Args, context _: inout Context) -> (UInt8?, Error?)
    {
        return (UInt8.random(in: 0...255), nil)
    }
}

extension RandomEnumeratedByteType: ByteFromArgsable
{
    public func byteFromArgs(args _: inout Args, context _: inout Context) -> (UInt8?, Error?)
    {
        return (self.randomOptions.randomElement(), nil)
    }
}

extension SemanticIntProducerByteType: ByteFromArgsable
{
    public func byteFromArgs(args: inout Args, context: inout Context) -> (UInt8?, Error?)
    {
        let (maybeB, byteError) = self.value.byteFromArgs(args: &args, context: &context)
        
        if byteError != nil
        {
            return (0, ByteFromArgsError.byteError)
        }
        
        guard let b = maybeB else
            { return (0, ByteFromArgsError.byteError) }
        
        let n = Int(b)
        context.set(name: self.name, value: n)
        
        return (b, nil)
    }
    
    enum ByteFromArgsError: Error
    {
        case byteError
    }
}

extension SemanticIntConsumerByteType: ByteFromArgsable
{
    public func byteFromArgs(args: inout Args, context: inout Context) -> (UInt8?, Error?)
    {
        let (value, ok) = context.getInt(name: self.name)
        
        if ok
        {
            return (UInt8(value), nil)
        }
        else
        {
            return (0, SemanticIntConsumerByteTypeError.undefinedVariableError)
        }
    }
    
    enum SemanticIntConsumerByteTypeError: Error
    {
        case undefinedVariableError
    }
}
