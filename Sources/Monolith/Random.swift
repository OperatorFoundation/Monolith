//
//  Random.swift
//  
//
//  Created by Mafalda & Blanu on 2/1/22.
//

import Crypto
import Foundation

import Datable

public struct MonolithRandomNumberGenerator: RandomNumberGenerator
{
    var state: Data
    var pool: Data
    
    public init(seed: UInt64)
    {
        self.state = seed.maybeNetworkData!
        self.pool = Data()
    }
    
    public mutating func next() -> UInt64
    {
        // Do we have anything left in the pool?
        if self.pool.count >= 8
        {
            let result = self.pool[0..<8]
            self.pool = self.pool[8...]
            
            return result.maybeNetworkUint64!
        }
        else
        {
            // No more bytes in the pool!
            // Hash the state
            let digest = SHA512.hash(data: self.state)
            let digestData = Data(digest)
            
            //split the data between the state and the pool
            self.state = digestData[0..<8]
            self.pool = digestData[8...]
            
            return self.next()
        }
    }
    
}
