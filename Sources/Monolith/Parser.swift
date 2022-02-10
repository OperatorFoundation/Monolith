
public protocol Parseable
{
    func Parse(buffer: Buffer, args: inout Args, context: inout Context)
}

enum ParserError: Error
{
    case popError
}

extension Description
{
    func Parse(buffer: Buffer, args: inout Args, context: inout Context)
    {
        for part in self.parts
        {
            part.Parse(buffer: buffer, args: &args, context: &context)
        }
    }
}

extension BytesPart: Parseable
{
    public func Parse(buffer: Buffer, args: inout Args, context: inout Context)
    {
        for item in self.items
        {
            item.Parse(buffer: buffer, args: &args, context: &context)
        }
    }
}

extension ByteTypeConfig: Parseable
{
    public func Parse(buffer: Buffer, args: inout Args, context: inout Context)
    {
        switch self
        {
            case .fixed(let fixedByteType):
                fixedByteType.Parse(buffer: buffer, args: &args, context: &context)
            case .enumerated(let enumeratedByteType):
                enumeratedByteType.Parse(buffer: buffer, args: &args, context: &context)
            case .random(let randomByteType):
                randomByteType.Parse(buffer: buffer, args: &args, context: &context)
            case .randomEnumerated(let randomEnumeratedByteType):
                randomEnumeratedByteType.Parse(buffer: buffer, args: &args, context: &context)
            case .semanticIntConsumer(let semanticIntConsumerByteType):
                semanticIntConsumerByteType.Parse(buffer: buffer, args: &args, context: &context)
            case .semanticIntProducer(let semanticIntProducerByteType):
                semanticIntProducerByteType.Parse(buffer: buffer, args: &args, context: &context)
        }
    }
}

extension MonolithConfig: Parseable
{
    public func Parse(buffer: Buffer, args: inout Args, context: inout Context)
    {
        switch self
        {
            case .bytes(let bytesPart):
                bytesPart.Parse(buffer: buffer, args: &args, context: &context)
        }
    }
}

extension FixedByteType: Parseable
{
    public func Parse(buffer: Buffer, args: inout Args, context: inout Context)
    {
        if buffer.isEmpty() {
            return
        }
        
       let (_, popError) = buffer.pop()
        if popError != nil {
            return
        }
    }
}

extension EnumeratedByteType: Parseable {
    public func Parse(buffer: Buffer, args: inout Args, context: inout Context)
    {
        if buffer.isEmpty() {
            return
        }
        
        let (arg, _) = buffer.pop()
        if buffer.isEmpty() {
            return
        }
        
        //TODO: reference this vs go if the code looks extra weird
        let options = self.options
        
        //TODO: use this to initialize a set
        let set = Set(options)
        if set.contains(arg) {
            return
        } else {
            return
        }
    }
}

extension RandomByteType: Parseable
{
    public func Parse(buffer: Buffer, args: inout Args, context: inout Context)
    {
        if buffer.isEmpty() {
            return
        }

       let (_, popError) = buffer.pop()
        if popError != nil {
            return
        }
    }
}

extension RandomEnumeratedByteType: Parseable
{
    public func Parse(buffer: Buffer, args: inout Args, context: inout Context)
    {
            if buffer.isEmpty() {
                return
            }
            
            let (arg, popError) = buffer.pop()
            if popError != nil {
                return
            }

        if self.randomOptions.contains(arg) {
                return
            } else {
                return
            }
        }
}
