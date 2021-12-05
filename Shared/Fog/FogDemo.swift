//
//  VisibilityDemo.swift
//  GraphMetal-Demo (iOS)
//
//  Created by Jim Hanson on 11/23/21.
//

import SwiftUI
import GenericGraph
import GraphMetal

class FogDemo: ObservableObject, RenderableGraphHolder {

    typealias GraphType = FogDemoGraph

    var graph: FogDemoGraph

    var povController: POVController

    var built = false

    @Published var rendererSettings = RendererSettings(nodeSize: 8,
                                                       nodeSizeAutomatic: false)

    @Published var visibilityLimitMax: Float = 1000

    init() {
        self.graph = FogDemoGraph()
        self.povController = POVController()
        povController.pov = makeInitialPOV()
    }

    func setup() {
        if !built {
            buildGraph()
            built = true
        }
    }

    func teardown() {
    }


    func makeInitialPOV() -> POV {
        return POV(location: SIMD3<Float>(-10, -10, -10))
    }

    func buildGraph() {

        let n0 = graph.addNode(FogDemoNodeValue(SIMD3<Float>(0, 0, 0)))

        var prev: NodeID = n0.id
        for x in 1...100 {
            let nx = graph.addNode(FogDemoNodeValue(SIMD3<Float>(Float(5 * x), 0, 0)))
            try! graph.addEdge(prev, nx.id, FogDemoEdgeValue())
            prev = nx.id
        }

        prev = n0.id
        for y in 1...100 {
            let ny = graph.addNode(FogDemoNodeValue(SIMD3<Float>(0, Float(10 * y), 0)))
            try! graph.addEdge(prev, ny.id, FogDemoEdgeValue())
            prev = ny.id
        }

        prev = n0.id
        for z in 1...100 {
            let nz = graph.addNode(FogDemoNodeValue(SIMD3<Float>(0, 0, Float(20 * z))))
            try! graph.addEdge(prev, nz.id, FogDemoEdgeValue())
            prev = nz.id
        }

        fireGraphChange(.ALL)
    }
}

struct FogDemoNodeValue: RenderableNodeValue {

    static let white = SIMD4<Float>(1, 1, 1, 1)

    var hidden: Bool { return false }

    var color: SIMD4<Float>? { return FogDemoNodeValue.white }

    var location: SIMD3<Float>

    init(_ location: SIMD3<Float>) {
        self.location = location
    }
}

struct FogDemoEdgeValue: RenderableEdgeValue {

    var hidden: Bool { return false }

}

typealias FogDemoGraph = BaseGraph<FogDemoNodeValue, FogDemoEdgeValue>

