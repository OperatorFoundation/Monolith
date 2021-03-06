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
    
    func testParts()
    {
        let correct = [
            BytesMessage(bytes: [0x0A]),
            BytesMessage(bytes: [0xB0])
        ]

        var parts: [Monolith] = []
        let part1 = BytesPart(Items: [FixedByteType(Byte: 0x0A)])
        parts.append(part1)
        let part2 = BytesPart(Items: [FixedByteType(Byte: 0xB0)])
        parts.append(part2)
        
        let desc = Description(Parts: parts)
        var instance = Instance(Desc: desc, Args: NewEmptyArgs())
        let result = instance.Messages()
        guard let byteResult = result as? [BytesMessage] else {
            XCTFail()
            return
        }
        XCTAssertEqual(byteResult, correct)
    }
    
    func testFixedItems()
    {
        let correct = [
            BytesMessage(bytes: [0x0A, 0x11]),
            BytesMessage(bytes: [0xB0, 0xB1])
        ]

        var parts: [Monolith] = []
        let part1 = BytesPart(Items: [
            FixedByteType(Byte: 0x0A),
            FixedByteType(Byte: 0x11)
        ])
        parts.append(part1)
        let part2 = BytesPart(Items: [
            FixedByteType(Byte: 0xB0),
            FixedByteType(Byte: 0xB1)
        ])
        parts.append(part2)
        
        let desc = Description(Parts: parts)
        var instance = Instance(Desc: desc, Args: NewEmptyArgs())
        let result = instance.Messages()
        guard let byteResult = result as? [BytesMessage] else {
            XCTFail()
            return
        }
        XCTAssertEqual(byteResult, correct)
    }
    
    func testEnumeratedItems()
    {
        let correct = [
            BytesMessage(bytes: [0x11, 0x12]),
            BytesMessage(bytes: [0x14, 0x13])
        ]

        let set: [uint8] = [0x11, 0x12, 0x13, 0x14]
        var parts: [Monolith] = []
        let part1 = BytesPart(Items: [
            EnumeratedByteType(Options: set),
            EnumeratedByteType(Options: set)
        ])
        parts.append(part1)
        let part2 = BytesPart(Items: [
            EnumeratedByteType(Options: set),
            EnumeratedByteType(Options: set)
        ])
        parts.append(part2)
        
        let desc = Description(Parts: parts)
        let args = NewArgs(values: [0x11, 0x12, 0x14, 0x13])
        var instance = Instance(Desc: desc, Args: args)
        let result = instance.Messages()
        guard let byteResult = result as? [BytesMessage] else {
            XCTFail()
            return
        }
        XCTAssertEqual(byteResult, correct)
    }
    
    func testRandomEnumeratedItems()
    {
        let set: [uint8] = [0x11, 0x12, 0x13, 0x14]
        
        var parts: [Monolith] = []
        let part1 = BytesPart(Items: [
            RandomEnumeratedByteType(RandomOptions: set),
            RandomEnumeratedByteType(RandomOptions: set)
        ])
        parts.append(part1)
        let part2 = BytesPart(Items: [
            RandomEnumeratedByteType(RandomOptions: set),
            RandomEnumeratedByteType(RandomOptions: set)
        ])
        parts.append(part2)
        
        let desc = Description(Parts: parts)
        let args = NewArgs(values: [0x11, 0x12, 0x14, 0x13])
        var instance = Instance(Desc: desc, Args: args)
        let result = instance.Messages()
        guard let byteResult = result as? [BytesMessage] else {
            XCTFail()
            return
        }
        XCTAssertEqual(byteResult.count, 2)
    }
    
    func testRandomItems()
    {
        // no correct var for random in swift
        var parts: [Monolith] = []
        let part1 = BytesPart(Items: [
            RandomByteType(),
            RandomByteType()
        ])
        parts.append(part1)
        let part2 = BytesPart(Items: [
            RandomByteType(),
            RandomByteType()
        ])
        parts.append(part2)
        
        let desc = Description(Parts: parts)
        let args = NewArgs(values: [0x11, 0x12, 0x14, 0x13])
        var instance = Instance(Desc: desc, Args: args)
        let result = instance.Messages()
        guard let byteResult = result as? [BytesMessage] else {
            XCTFail()
            return
        }
        //check to make sure result is of the right length(2)
        XCTAssertEqual(byteResult.count, 2)
    }
//    func TestTimedParts()
//    {
//        let correct = [
//            TimedMessage(Milliseconds: 0, bytes: [0x0A]),
//            TimedMessage(Milliseconds: 0, bytes: [0xB0])
//        ]
//
//        var parts: [Monolith] = []
//        let part1 = BytesPart(Items: [
//            TimedPart(Milliseconds: 0, Items: [ByteType(FixedByteType(Byte: 0x0A))])
//        ])
//        parts.append(part1)
//        let part2 = BytesPart(Items: [
//            RandomByteType(),
//            RandomByteType()
//        ])
//        parts.append(part2)
//
//        let desc = Description(Parts: parts)
//        let args = NewArgs(values: [0x11, 0x12, 0x14, 0x13])
//        var instance = Instance(Desc: desc, Args: args)
//        let result = instance.Messages()
//        guard let byteResult = result as? [BytesMessage] else {
//            XCTFail()
//            return
//        }
//        XCTAssertEqual(byteResult, correct)
//
//    }
    
}
