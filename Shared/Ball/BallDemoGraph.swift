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

    var color: SIMD4<Float>? {
        let h = fmod(Float(Date().timeIntervalSince(creationTime)), 60)
        let x = 1 - abs(fmod(h, 2) - 1)
        if h < 10 {
            return SIMD4<Float>(1, x, 0, 1)
        }
        else if h < 20 {
            return SIMD4<Float>(x, 1, 0, 1)
        }
        else if h < 30 {
            return SIMD4<Float>(0, 1, x, 1)
        }
        else if h < 40 {
            return SIMD4<Float>(0, x, 1, 1)
        }
        else if h < 50 {
            return SIMD4<Float>(x, 0, 1, 1)
        }
        else {
            return SIMD4<Float>(1, 0, x, 1)
        }
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


