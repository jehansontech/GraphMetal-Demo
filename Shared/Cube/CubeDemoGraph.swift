//
//  CubeDemoGraph.swift
//  GraphMetal-Demo
//
//  Created by Jim Hanson on 12/13/21.
//

import GenericGraph
import GraphMetal

struct CubeDemoNodeValue: RenderableNodeValue {

    var color: SIMD4<Float>? { return CubeDemo.graphColor }

    var location: SIMD3<Float>

    init(_ location: SIMD3<Float>) {
        self.location = location
    }
}

struct CubeDemoEdgeValue: RenderableEdgeValue {

    var hidden: Bool { return false }

}

typealias CubeDemoGraph = BaseGraph<CubeDemoNodeValue, CubeDemoEdgeValue>

