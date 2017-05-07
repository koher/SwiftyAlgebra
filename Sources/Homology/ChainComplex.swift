//
//  ChainComplex.swift
//  SwiftyAlgebra
//
//  Created by Taketo Sano on 2017/05/04.
//  Copyright © 2017年 Taketo Sano. All rights reserved.
//

import Foundation

public struct ChainComplex<A: Hashable, R: Ring>: CustomStringConvertible {
    public typealias M = FreeModule<A, R>
    public typealias F = FreeModuleHom<A, R>
    
    public let chainBases: [[A]] // [[0-chain], [1-chain], ..., [n-chain]]
    public let boundaryMaps: [F] // [(d_0 = 0), (d_1 = C_1 -> C_0), ..., (d_n: C_n -> C_{n-1}), (d_{n+1} = 0)]
    
    public init(chainBases: [[A]], boundaryMaps: [F]) {
        self.chainBases = chainBases
        self.boundaryMaps = boundaryMaps
    }
    
    public func boundaryMap(_ i: Int) -> FreeModuleHom<A, R> {
        return boundaryMaps[i]
    }
    
    public var description: String {
        return chainBases.description
    }
}