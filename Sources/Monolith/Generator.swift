import Foundation

struct Instance {
    let Desc: Description
    var Args: Args
}

extension Instance {
    func Messages() -> [Message] {
        let context = NewEmptyContext()
        let ms = self.Desc.MessagesFromArgs(self.Args, context)
        let result: [Message] = []
        //TODO: the for loop uses range/len , which dont seem to be in swift
        return result
    }
}

extension Description
{
    func generate() -> Data
    {
        var generated: [Data] = []
        var count = 0

        for part in self.parts
        {
            let generatedPart = part.generate()
            count = count + generatedPart.count
            generated.append(generatedPart)
        }

        var result = Data(capacity: count)
        for part in generated
        {
            result.append(part)
        }
        return result
    }
}

extension Part
{
    func generate() -> Data
    {
        switch(self)
        {
            case .bytes(count: let count, let byteType):
                var results = Data(capacity: count)
                for _ in [..<count]
                {
                    guard let result = byteType.generate() else { continue }
                    results.append(result)
                }
                return results
            default:
                return Data()
        }
    }
}

//extension ByteType
//{
//    func generate() -> Byte?
//    {
//        switch(self)
//        {
//            case .fixed(let byte):
//                return byte
//            case .enumerated(let set):
//                return set.first
//            case .random():
//                return UInt8.random(in: 0..<255)
//            case .semantic(let constraint):
//                return 0
//            default:
//                return nil
//        }
//    }
//}
