//
//  MotionDemoGraph.swift
//  GraphMetal-Demo (iOS)
//
//  Created by Jim Hanson on 12/14/21.
//

import GenericGraph
import GraphMetal

struct MotionDemoNodeValue: RenderableNodeValue {

    var hidden: Bool { return false }

    var color: SIMD4<Float>? { return MotionDemo.graphColor }

    var location: SIMD3<Float>

    init(_ location: SIMD3<Float>) {
        self.location = location
    }
}

struct MotionDemoEdgeValue: RenderableEdgeValue {

    var hidden: Bool { return false }

}

typealias MotionDemoGraph = BaseGraph<MotionDemoNodeValue, MotionDemoEdgeValue>

