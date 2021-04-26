//
//  Persistence.swift
//  Monolith
//
//  Created by Mafalda on 7/20/20.
//
//
//import Foundation
//import Song
//
//enum PersistenceError: Error {
//    case decodeError
//}
//
//func DecodeInstance(encoded: String) -> (Instance?, Error?) {
//    var songDecoder = SongDecoder()
//    guard let instance = songDecoder.decode(Instance.self, encoded) else {
//        return (nil, PersistenceError.decodeError)
//    }
//
//    return (instance, nil)
//}
//
//func DecodeDescription(encoded: String) -> (Description, Error) {
//    var description: Description
//    return (description, nil)
//}
