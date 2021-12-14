//
//  BallDemoGraph.swift
//  GraphMetal-Demo
//
//  Created by Jim Hanson on 12/13/21.
//

import Foundation
import GenericGraph
import GraphMetal

struct BallDemoNodeValue: RenderableNodeValue {

    let colorFadeTime: TimeInterval = 5

    var hidden: Bool { return false }

    var color: SIMD4<Float>? {
        let f: Float = Float(Date().timeIntervalSince(creationTime) / colorFadeTime)
        return SIMD4<Float>(0,
                            (1 - f).clamp(0, 1),
                            0.5 * (1 - f).clamp(0, 1),
                            1)
    }

    var location: SIMD3<Float>

    let creationTime: Date

    init(_ location: SIMD3<Float>) {
        self.location = location
        self.creationTime = Date()
    }
}

struct BallDemoEdgeValue: RenderableEdgeValue {

    var hidden: Bool { return false }
}

typealias BallDemoGraph = BaseGraph<BallDemoNodeValue, BallDemoEdgeValue>


