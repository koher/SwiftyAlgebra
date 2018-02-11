//
//  GeometricComplexExtensions.swift
//  SwiftyAlgebra
//
//  Created by Taketo Sano on 2018/02/10.
//  Copyright © 2018年 Taketo Sano. All rights reserved.
//

import Foundation

public extension ChainComplex where chainType == Descending {
    public init<C: GeometricComplex>(_ K: C, _ type: R.Type) where A == C.Cell {
        let chain = K.validDims.map{ (i) -> (ChainBasis, BoundaryMap, BoundaryMatrix) in
            (K.cells(ofDim: i), K.boundaryMap(i, R.self), K.boundaryMatrix(i, R.self))
        }
        self.init(name: K.name, chain)
    }
    
    public init<C: GeometricComplex>(_ K: C, _ L: C, _ type: R.Type) where A == C.Cell {
        let chain = K.validDims.map{ (i) -> (ChainBasis, BoundaryMap, BoundaryMatrix) in
            
            let from = K.cells(ofDim: i).subtract(L.cells(ofDim: i))
            let to   = K.cells(ofDim: i - 1).subtract(L.cells(ofDim: i - 1))
            let map  = K.boundaryMap(i, R.self)
            let matrix = K.partialBoundaryMatrix(from, to, R.self)
            
            return (from, map, matrix)
        }
        self.init(name: "\(K.name), \(L.name)", chain)
    }
}

public extension CochainComplex where chainType == Ascending {
    public init<C: GeometricComplex>(_ K: C, _ type: R.Type) where Dual<C.Cell> == A {
        let cochain = K.validDims.map{ (i) -> (ChainBasis, BoundaryMap, BoundaryMatrix) in
            let from = K.cells(ofDim: i)
            let to   = K.cells(ofDim: i + 1)
            
            let map = BoundaryMap { d in FreeModule(K.coboundary(d, R.self)) }
            
            let e = R(intValue: (-1).pow(i + 1))
            let matrix = K.partialBoundaryMatrix(to, from, R.self)
                .transpose()
                .multiply(e)
            
            return (from.map{ Dual($0) }, map, matrix)
        }
        self.init(name: K.name, cochain)
    }
    
    public init<C: GeometricComplex>(_ K: C, _ L: C, _ type: R.Type) where Dual<C.Cell> == A {
        let cochain = K.validDims.map{ (i) -> (ChainBasis, BoundaryMap, BoundaryMatrix) in
            let from = K.cells(ofDim: i).subtract(L.cells(ofDim: i))
            let to   = K.cells(ofDim: i + 1).subtract(L.cells(ofDim: i + 1))
            
            let map = BoundaryMap { d in
                let c = K.coboundary(d, R.self)
                let vals = c.filter{ (d, _) in to.contains( d.base ) }
                return FreeModule(vals)
            }
            
            let e = R(intValue: (-1).pow(i + 1))
            let matrix = K.partialBoundaryMatrix(to, from, R.self)
                .transpose()
                .multiply(e)
            
            return (from.map{ Dual($0) }, map, matrix)
        }
        self.init(name: "\(K.name), \(L.name)", cochain)
    }
}

public extension Homology where chainType == Descending {
    public convenience init<C: GeometricComplex>(_ K: C, _ type: R.Type) where C.Cell == A {
        let c = ChainComplex(K, type)
        self.init(c)
    }
    
    public convenience init<C: GeometricComplex>(_ K: C, _ L: C, _ type: R.Type) where C.Cell == A {
        let c = ChainComplex(K, L, type)
        self.init(c)
    }
}

public extension Cohomology where chainType == Ascending {
    public convenience init<C: GeometricComplex>(_ K: C, _ type: R.Type) where Dual<C.Cell> == A {
        let c = CochainComplex(K, type)
        self.init(c)
    }
    
    public convenience init<C: GeometricComplex>(_ K: C, _ L: C, _ type: R.Type) where Dual<C.Cell> == A {
        let c = CochainComplex(K, L, type)
        self.init(c)
    }
}