//
//  CubeDemoGraph.swift
//  GraphMetal-Demo
//
//  Created by Jim Hanson on 12/13/21.
//

import GenericGraph
import GraphMetal

struct CubeDemoNodeValue: EmbeddedValue {

    var location: SIMD3<Float>

    init(_ location: SIMD3<Float>) {
        self.location = location
    }
}

typealias CubeDemoGraph = BaseGraph<CubeDemoNodeValue, Void>
