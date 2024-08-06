//
//  ZWireframeGraph.swift
//  GraphMetal-Demo
//
//  Created by Jim Hanson on 7/30/24.
//

import GenericGraph
import GraphMetal

struct ZWireframeNodeValue: EmbeddedValue, ColoredValue {

    var color: SIMD4<Float>?  = nil

    var location: SIMD3<Float>

    init(_ location: SIMD3<Float>) {
        self.location = location
    }
}

struct ZWireframeEdgeValue: ColoredValue {

    var color: SIMD4<Float>? = nil
}

typealias ZWireframeGraph = BaseGraph<ZWireframeNodeValue, ZWireframeEdgeValue>
