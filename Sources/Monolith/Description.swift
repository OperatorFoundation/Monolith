import Foundation

struct Description
{
    let parts: [Part]
}

enum Part
{
    case bytes(count: Int, ByteType)
}

typealias Byte = UInt8

enum ByteType
{
    case fixed(Byte)
    case enumerated(Set<Byte>)
    case random(Void)
    case semantic(Constraint<Byte>)
}

struct Constraint<Value>
{
    
}
