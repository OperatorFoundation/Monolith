//
//  Validator.swift
//  Monolith
//
//  Created by Mafalda on 7/20/20.
//

import Foundation

public enum Validity: String {
    case Valid
    case Invalid
    case Incomplete
}

extension Validity {
    // FIXME: I don't know where to start
    func String() -> String {
        return self.rawValue
    }
}

public protocol Validateable {
    //FIXME: uses an internal type?
    func Validate(buffer: Buffer, context: Context) -> Validity
}

extension Description {
    func Validate(buffer: Buffer, context: Context) -> Validity {
        for part in self.Parts {
            let valid = part.Validate(buffer: buffer, context: context)
            switch valid {
            case .Valid:
                continue
            case .Invalid:
                return .Invalid
            case .Incomplete:
                return .Incomplete
            }
        }
        
        return .Valid
    }
}

extension BytesPart {
    func Validate(buffer: Buffer, context: Context) -> Validity {
        for item in self.Items {
            let valid = item.Validate(buffer: buffer, context: context)
            switch valid {
            case .Valid:
                continue
            case .Invalid:
                return .Invalid
            case .Incomplete:
                return .Incomplete
            }
        }
        return .Valid
    }
}

extension FixedByteType {
    func Validate(buffer: Buffer, _: Context) -> Validity {
        if buffer.Empty() {
            return .Incomplete
        }
        
        let (b, popError) = buffer.Pop()
        
        if popError != nil {
            return .Invalid
        }
        
        if b == self.Byte {
            return .Valid
        } else {
            return .Invalid
        }
    }
}

extension EnumeratedByteType {
    func Validate(buffer: Buffer, _: Context) -> Validity {
        if buffer.Empty() {
            return .Incomplete
        }
        
        let (b, popError) = buffer.Pop()
        if popError != nil {
            return .Invalid
        }
        
        if self.Options.contains(b) {
            return .Valid
        } else {
            return .Invalid
        }
    }
}

extension RandomByteType {
    func Validate(buffer: Buffer, _: Context) -> Validity {
        if buffer.Empty() {
            return .Incomplete
        }
        
        let (_, popError) = buffer.Pop()
        if popError != nil {
            return .Invalid
        }
        return .Valid
    }
}

extension RandomEnumeratedByteType {
    func Validate(buffer: Buffer, _: Context) -> Validity {
        if buffer.Empty() {
            return .Incomplete
        }
        
        let (b, popError) = buffer.Pop()
        if popError != nil {
            return .Invalid
        }
        
        if self.RandomOptions.contains(b) {
            return .Valid
        } else {
            return .Invalid
        }
    }
}
