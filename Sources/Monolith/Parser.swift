
protocol Parseable {
    func Parse(buffer: Buffer, args: Args, context: Context)
}
enum ParserError: Error {
    case popError
}
extension Description {
    func Parse(buffer: Buffer, args: Args, context: Context) {
        for (_, part) in range self.Parts {
            part.Parse(buffer, args, context)
        }
    }
}

extension BytesPart {
    func Parse(buffer: Buffer, args: Args, context: Context) {
        //FIXME moar go sequences
    }
}

extension FixedByType {
    func Parse(buffer: Buffer, _: Args, _: Context) {
        if buffer.Empty() {
            return
        }
        
       let (_, popError) = buffer.Pop()
        if buffer.Empty() {
            return
        }
    }
}

extension EnumeratedByteType {
    func Parse(buffer: Buffer, _: Args, _: Context) {
        if buffer.Empty() {
            return
        }
        
        let (arg, _) = buffer.Pop()
        if buffer.Empty() {
            return
        }
        
        //TODO: reference this vs go if the code looks extra weird
        let options = self.Options
        
        //TODO: use this to initialize a set
        let set = Set(options)
        if set.contains(arg) {
            return
        } else {
            return
        }
    }
}
