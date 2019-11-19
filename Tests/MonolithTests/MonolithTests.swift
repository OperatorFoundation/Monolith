import XCTest
@testable import Monolith
import Datable

final class MonolithTests: XCTestCase
{
    func testDescription()
    {
        let b1 = Byte(0x01)
        let b2 = Byte(0x02)
                
        let parts: [Part] = [
            Part.bytes(count: 1, .fixed(0)),
            Part.bytes(count: 1, ByteType.enumerated(Set<Byte>(arrayLiteral: b1, b2))),
            Part.bytes(count: 1, .random(())),
            Part.bytes(count: 1, .semantic(Constraint<Byte>())),
        ]
        
        let desc = Description(parts: parts)
        print(desc)
    }
    
    func testGenerate()
    {
        let b1 = Byte(0x01)
        let b2 = Byte(0x02)
                
        let parts: [Part] = [
            Part.bytes(count: 1, .fixed(0)),
            Part.bytes(count: 1, ByteType.enumerated(Set<Byte>(arrayLiteral: b1, b2))),
            Part.bytes(count: 1, .random(())),
            Part.bytes(count: 1, .semantic(Constraint<Byte>())),
        ]
        
        let desc = Description(parts: parts)
        print(desc)
        
        let data = desc.generate()
        print("\(data as! NSData)")
    }
}
