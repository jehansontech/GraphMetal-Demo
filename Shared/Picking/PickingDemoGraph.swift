//
//  PickingDemoGraph.swift
//  GraphMetal-Demo
//
//  Created by Jim Hanson on 12/15/21.
//

import GenericGraph
import GraphMetal

struct PickingDemoNodeValue: RenderableNodeValue {

    static let groupColors: [SIMD4<Float>] = [
        SIMD4<Float>(1, 0, 0, 1),
        SIMD4<Float>(0, 1, 0, 1),
        SIMD4<Float>(1, 1, 0, 1)
    ]

    var hidden: Bool { return false }

    var color: SIMD4<Float>? {
        return Self.groupColors[_group]
    }

    var group: Int {
        get {
            return _group
        }

        set(newValue) {
            _group = newValue.clamp(0, Self.groupColors.count-1)
        }
    }

    private var _group: Int = 0

    var location: SIMD3<Float>

    init(_ location: SIMD3<Float>) {
        self.location = location
    }
}

struct PickingDemoEdgeValue: RenderableEdgeValue {

    var hidden: Bool { return false }

}

typealias PickingDemoNode = BaseGraphNode<PickingDemoNodeValue, PickingDemoEdgeValue>
typealias PickingDemoGraph = BaseGraph<PickingDemoNodeValue, PickingDemoEdgeValue>

