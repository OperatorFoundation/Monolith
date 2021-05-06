import XCTest
@testable import Monolith
import Datable

final class MonolithTests: XCTestCase
{
    func testDescription()
    {
        let correct = [BytesMessage](arrayLiteral: BytesMessage(bytes: [UInt8](arrayLiteral: 0x0A)))
        var parts: [Monolith] = []
        let part = BytesPart(Items: [FixedByteType(Byte: 0x0A)])
        parts.append(part)
        let desc = Description(Parts: parts)
        var instance = Instance(Desc: desc, Args: NewEmptyArgs())
        let result = instance.Messages()
        guard let byteResult = result as? [BytesMessage] else {
            XCTFail()
            return
        }
        XCTAssertEqual(byteResult, correct)
    }
    
    func testGenerate()
    {
//        let b1 = Byte(0x01)
//        let b2 = Byte(0x02)
//
//        let parts: [Part] = [
//            Part.bytes(count: 1, .fixed(0)),
//            Part.bytes(count: 1, ByteType.enumerated(Set<Byte>(arrayLiteral: b1, b2))),
//            Part.bytes(count: 1, .random(())),
//            Part.bytes(count: 1, .semantic(Constraint<Byte>())),
//        ]
//
//        let desc = Description(parts: parts)
//        print(desc)
//
//        let data = desc.generate()
//        print("\(data as! NSData)")
    }
}
