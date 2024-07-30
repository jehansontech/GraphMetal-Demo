//
//  Wireframe2Graph.swift
//  GraphMetal-Demo
//
//  Created by Jim Hanson on 7/30/24.
//

import GenericGraph
import GraphMetal

struct Wireframe2NodeValue: EmbeddedValue, ColoredValue {

    var color: SIMD4<Float>?  = nil

    var location: SIMD3<Float>

    init(_ location: SIMD3<Float>) {
        self.location = location
    }
}

struct Wireframe2EdgeValue: ColoredValue {

    var color: SIMD4<Float>? = nil
}

typealias Wireframe2Graph = BaseGraph<Wireframe2NodeValue, Wireframe2EdgeValue>
