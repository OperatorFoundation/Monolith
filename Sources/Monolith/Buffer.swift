//
//  Buffer.swift
//  Monolith
//
//  Created by Mafalda on 7/20/20.
//

import Foundation

struct Buffer {
    let value: [Byte]
}

func NewEmptyBuffer() -> Buffer {
    value = make([Byte], 0)
    return Buffer{value:value}
}

func NewBuffer(value: [Byte]) -> Buffer {
    return Buffer{value:value}
}
