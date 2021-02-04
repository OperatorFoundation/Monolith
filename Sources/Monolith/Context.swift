//
//  Context.swift
//  Monolith
//
//  Created by Mafalda on 7/20/20.
//

import Foundation

struct Context {
    //This replaces map of strings to interface. Any represents...well... anything
    let values: [String:Any]
}

func NewEmptyContext() -> Context {
    values = String//map[string]interface
    return Context{values:vallues}
}
