//
//  Args.swift
//  Monolith
//
//  Created by Mafalda on 7/20/20.
//

import Foundation

struct Args {
    let Values: [Protocol]
    let Index: Int
}

func NewEmptyArgs() -> Args {
    return Args.init(Values: <#T##[Protocol]#>, Index: 0)
}

func NewArgs(values: [Protocol]) -> Args {
    return Args.init(Values: values, Index: 0)
}
