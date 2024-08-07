//
//  ZWireframeGraph.swift
//  GraphMetal-Demo
//
//  Created by Jim Hanson on 7/30/24.
//

import GenericGraph
import GraphMetal

fileprivate func nextColor(_ count: Int) -> SIMD4<Float>? {
    switch count % 3 {
    case 0:
        return SIMD4<Float>(1, 0, 0, 1)
    case 1:
        return SIMD4<Float>(0, 1, 0, 1)
    case 2:
        return SIMD4<Float>(0, 0, 1, 1)
    default:
        return .zero
    }
}

struct ZWireframeNodeValue: EmbeddedValue, ColoredValue {

    private static var createdCount: Int = 0

    var location: SIMD3<Float>

    var color: SIMD4<Float>? = nil

    init(_ location: SIMD3<Float>) {
        Self.createdCount += 1
        self.location = location
        self.color = nextColor(Self.createdCount)
    }
}

struct ZWireframeEdgeValue: ColoredValue {

    private static var createdCount: Int = 0

    var color: SIMD4<Float>? = nil

    init() {
        Self.createdCount += 1
        self.color = nextColor(Self.createdCount)
    }
}

typealias ZWireframeGraph = BaseGraph<ZWireframeNodeValue, ZWireframeEdgeValue>
