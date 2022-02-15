
public protocol Parseable
{
    func parse(buffer: Buffer, args: inout Args, context: inout Context)
}

enum ParserError: Error
{
    case popError
}

extension Description: Parseable
{
    public func parse(buffer: Buffer, args: inout Args, context: inout Context)
    {
        for part in self.parts
        {
            part.parse(buffer: buffer, args: &args, context: &context)
        }
    }
}

extension BytesPart: Parseable
{
    public func parse(buffer: Buffer, args: inout Args, context: inout Context)
    {
        for item in self.items
        {
            item.parse(buffer: buffer, args: &args, context: &context)
        }
    }
}

extension ByteTypeConfig: Parseable
{
    public func parse(buffer: Buffer, args: inout Args, context: inout Context)
    {
        switch self
        {
            case .fixed(let fixedByteType):
                fixedByteType.parse(buffer: buffer, args: &args, context: &context)
            case .enumerated(let enumeratedByteType):
                enumeratedByteType.parse(buffer: buffer, args: &args, context: &context)
            case .random(let randomByteType):
                randomByteType.parse(buffer: buffer, args: &args, context: &context)
            case .randomEnumerated(let randomEnumeratedByteType):
                randomEnumeratedByteType.parse(buffer: buffer, args: &args, context: &context)
            case .semanticIntConsumer(let semanticIntConsumerByteType):
                semanticIntConsumerByteType.parse(buffer: buffer, args: &args, context: &context)
            case .semanticIntProducer(let semanticIntProducerByteType):
                semanticIntProducerByteType.parse(buffer: buffer, args: &args, context: &context)
        }
    }
}

extension MonolithConfig: Parseable
{
    public func parse(buffer: Buffer, args: inout Args, context: inout Context)
    {
        switch self
        {
            case .bytes(let bytesPart):
                bytesPart.parse(buffer: buffer, args: &args, context: &context)
        }
    }
}

extension FixedByteType: Parseable
{
    public func parse(buffer: Buffer, args: inout Args, context: inout Context)
    {
        if buffer.isEmpty()
        {
            return
        }
        
       let _ = buffer.pop()
        
//        if popError != nil
//        {
//            return
//        }
    }
}

extension EnumeratedByteType: Parseable
{
    public func parse(buffer: Buffer, args: inout Args, context: inout Context)
    {
        if buffer.isEmpty()
        {
            return
        }
        
        let maybeArg = buffer.pop()
        
        if buffer.isEmpty()
        {
            return
        }
                
        let set = Set(options)
        
        guard let arg = maybeArg else
        {
            return
        }
        
        // FIXME: What is the intent here?
        
        if set.contains(arg)
        {
            if let typeName = self.name
            {
                context.set(name: typeName, value: arg)
            }
            
            return
        }
        else
        {
            return
        }
    }
}

extension RandomByteType: Parseable
{
    public func parse(buffer: Buffer, args: inout Args, context: inout Context)
    {
        if buffer.isEmpty()
        {
            return
        }

       let _ = buffer.pop()
        
//        if popError != nil
//        {
//            return
//        }
    }
}

extension RandomEnumeratedByteType: Parseable
{
    public func parse(buffer: Buffer, args: inout Args, context: inout Context)
    {
        if buffer.isEmpty()
        {
            return
        }
        
        let maybeArg = buffer.pop()
        
        guard let arg = maybeArg else
            { return }

        if self.randomOptions.contains(arg)
        {
            return
        }
        else
        {
            return
        }
    }
}

extension SemanticIntConsumerByteType: Parseable
{
    public func parse(buffer: Buffer, args: inout Args, context: inout Context)
    {
        if buffer.isEmpty()
        {
            return
        }
        
        let maybeFirst = buffer.pop()
        
        guard let first = maybeFirst else
            { return }
        
        let n = Int(first)
        
        let (value, ok) = context.getInt(name: self.name)
        
        if ok
        {
            if n == value
            {
                args.push(value: .int(n))
            }
        }
    }
}

extension SemanticIntProducerByteType: Parseable
{
    public func parse(buffer: Buffer, args: inout Args, context: inout Context)
    {
        if buffer.isEmpty()
        {
            return
        }
        
        let maybeFirst = buffer.pop()
        
        guard let first = maybeFirst else
            { return }
        
        let value = Int(first)
        
        context.set(name: self.name, value: value)
    }
}
