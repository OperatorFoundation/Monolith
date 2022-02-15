import XCTest
@testable import Monolith
import Datable
import Song

final class MonolithTests: XCTestCase
{
    func testDescription()
    {
        let correct = [BytesMessage](arrayLiteral: BytesMessage(messageBytes: [UInt8](arrayLiteral: 0x0A)))
        var parts: [MonolithPart] = []
        let part = MonolithPart.bytes(BytesPart(items: [.fixed(FixedByteType(byte: 0x0A))]))
        parts.append(part)
        let desc = Description(parts: parts)
        var instance = Instance(description: desc, args: Args())
        let result = instance.messages()
        guard let byteResult = result as? [BytesMessage] else {
            XCTFail()
            return
        }
        XCTAssertEqual(byteResult, correct)
    }
    
//    func testDescriptionSongSerialization()
//    {
//        var parts: [MonolithConfig] = []
//        let part: MonolithConfig = .bytes(BytesPart(Items: [.fixed(FixedByteType(Byte: 0x0A))]))
//        parts.append(part)
//        let description = Description(Parts: parts)
//
//        let encoder = SongEncoder()
//
//        guard let _ = try? encoder.encode(description)
//        else
//        {
//            XCTFail()
//            return
//        }
//    }
    
    func testDescriptionJSONSerialization()
    {
        var parts: [MonolithPart] = []
        let part: MonolithPart = .bytes(BytesPart(items: [.fixed(FixedByteType(byte: 0x0A))]))
        parts.append(part)
        let description = Description(parts: parts)

        let encoder = JSONEncoder()

        guard let _ = try? encoder.encode(description)
        else
        {
            XCTFail()
            return
        }
    }
    
    func testParts()
    {
        let correct = [
            BytesMessage(messageBytes: [0x0A]),
            BytesMessage(messageBytes: [0xB0])
        ]

        var parts: [MonolithPart] = []
        let part1: MonolithPart = .bytes(BytesPart(items: [.fixed(FixedByteType(byte: 0x0A))]))
        parts.append(part1)
        let part2: MonolithPart = .bytes(BytesPart(items: [.fixed(FixedByteType(byte: 0xB0))]))
        parts.append(part2)
        
        let desc = Description(parts: parts)
        var instance = Instance(description: desc, args: Args())
        let result = instance.messages()
        guard let byteResult = result as? [BytesMessage] else {
            XCTFail()
            return
        }
        XCTAssertEqual(byteResult, correct)
    }
    
    func testFixedItems()
    {
        let correct = [
            BytesMessage(messageBytes: [0x0A, 0x11]),
            BytesMessage(messageBytes: [0xB0, 0xB1])
        ]

        var parts: [MonolithPart] = []
        let part1: MonolithPart = .bytes(BytesPart(items: [
            .fixed(FixedByteType(byte: 0x0A)),
            .fixed(FixedByteType(byte: 0x11))
        ]))
        parts.append(part1)
        let part2: MonolithPart = .bytes(BytesPart(items: [
            .fixed(FixedByteType(byte: 0xB0)),
            .fixed(FixedByteType(byte: 0xB1))
        ]))
        parts.append(part2)
        
        let desc = Description(parts: parts)
        var instance = Instance(description: desc, args: Args())
        let result = instance.messages()
        guard let byteResult = result as? [BytesMessage] else {
            XCTFail()
            return
        }
        XCTAssertEqual(byteResult, correct)
    }
    
    func testEnumeratedItems()
    {
        let correct = [
            BytesMessage(messageBytes: [0x11, 0x12]),
            BytesMessage(messageBytes: [0x14, 0x13])
        ]

        let set: [uint8] = [0x11, 0x12, 0x13, 0x14]
        var parts: [MonolithPart] = []
        let part1: MonolithPart = .bytes(BytesPart(items: [
            .enumerated(EnumeratedByteType(options: set)),
            .enumerated(EnumeratedByteType(options: set))
        ]))
        parts.append(part1)
        let part2: MonolithPart = .bytes(BytesPart(items: [
            .enumerated(EnumeratedByteType(options: set)),
            .enumerated(EnumeratedByteType(options: set))
        ]))
        parts.append(part2)
        
        let desc = Description(parts: parts)
        let args = Args(byteValues: [0x11, 0x12, 0x14, 0x13])
        var instance = Instance(description: desc, args: args)
        let result = instance.messages()
        guard let byteResult = result as? [BytesMessage] else {
            XCTFail()
            return
        }
        
        XCTAssertEqual(byteResult, correct)
    }
    
    func testRandomEnumeratedItems()
    {
        let set: [uint8] = [0x11, 0x12, 0x13, 0x14]
        
        var parts: [MonolithPart] = []
        let part1: MonolithPart = .bytes(BytesPart(items: [
            .randomEnumerated(RandomEnumeratedByteType(randomOptions: set)),
            .randomEnumerated(RandomEnumeratedByteType(randomOptions: set))
        ]))
        parts.append(part1)
        let part2: MonolithPart = .bytes(BytesPart(items: [
            .randomEnumerated(RandomEnumeratedByteType(randomOptions: set)),
            .randomEnumerated(RandomEnumeratedByteType(randomOptions: set))
        ]))
        parts.append(part2)
        
        let desc = Description(parts: parts)
        let args = Args(byteValues: [0x11, 0x12, 0x14, 0x13])
        var instance = Instance(description: desc, args: args)
        let result = instance.messages()
        guard let byteResult = result as? [BytesMessage] else {
            XCTFail()
            return
        }
        XCTAssertEqual(byteResult.count, 2)
    }
    
    func testRandomItems()
    {
        // no correct var for random in swift
        var parts: [MonolithPart] = []
        let part1: MonolithPart = .bytes(BytesPart(items: [
            .random(RandomByteType()),
            .random(RandomByteType())
        ]))
        parts.append(part1)
        let part2: MonolithPart = .bytes(BytesPart(items: [
            .random(RandomByteType()),
            .random(RandomByteType())
        ]))
        parts.append(part2)
        
        let desc = Description(parts: parts)
        let args = Args(byteValues: [0x11, 0x12, 0x14, 0x13])
        var instance = Instance(description: desc, args: args)
        let result = instance.messages()
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
//            TimedMessage(milliseconds: 0, bytes: [0x0A]),
//            TimedMessage(milliseconds: 0, bytes: [0xB0])
//        ]
//
//        var parts: [MonolithConfig] = []
//        let part1: MonolithConfig = .bytes(BytesPart(Items: [
//            .timed(TimedPart(Milliseconds: 0, Items: [ByteType(FixedByteType(Byte: 0x0A))]))
//        ]))
//        parts.append(part1)
//        let part2: MonolithConfig = .bytes(BytesPart(items: [
//            .random(RandomByteType()),
//            .random(RandomByteType())
//        ]))
//        parts.append(part2)
//
//        let desc = Description(parts: parts)
//        let args = NewArgs(values: [0x11, 0x12, 0x14, 0x13])
//        var instance = Instance(description: desc, args: args)
//        let result = instance.Messages()
//        guard let byteResult = result as? [BytesMessage] else {
//            XCTFail()
//            return
//        }
//
//        XCTAssertEqual(byteResult, correct)
//    }
    
}
