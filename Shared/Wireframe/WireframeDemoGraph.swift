//
//  WireframeDemoGraph.swift
//  GraphMetal-Demo
//
//  Created by Jim Hanson on 12/13/21.
//

import GenericGraph
import GraphMetal

struct WireframeDemoNodeValue: RenderableNodeValue {

    var hidden: Bool { return false }

    var color: SIMD4<Float>? { return nil }

    var location: SIMD3<Float>

    init(_ location: SIMD3<Float>) {
        self.location = location
    }
}

struct WireframeDemoEdgeValue: RenderableEdgeValue {

    var hidden: Bool { return false }
}

typealias WireframeDemoGraph = BaseGraph<WireframeDemoNodeValue, WireframeDemoEdgeValue>
