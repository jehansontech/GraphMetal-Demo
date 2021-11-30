//
//  DimmingDemo.swift
//  GraphMetal-Demo (iOS)
//
//  Created by Jim Hanson on 11/23/21.
//

import SwiftUI
import GenericGraph
import GraphMetal

class DimmingDemo: ObservableObject, RenderableGraphHolder {

    typealias GraphType = DimmingDemoGraph

    var graph: DimmingDemoGraph

    var povController: POVController

    @Published var rendererSettings = RendererSettings(nodeSize: 5,
                                                       nodeSizeAutomatic: false)

    init() {
        self.graph = DimmingDemoGraph()
        self.povController = POVController()
        povController.pov = makeInitialPOV()
    }

    func setup() {
        buildGraph()
    }

    func teardown() {
        graph = DimmingDemoGraph()
    }


    func makeInitialPOV() -> POV {
        return POV(location: SIMD3<Float>(-10, -10, -10))
    }

    func buildGraph() {

        let n0 = graph.addNode(DimmingDemoNodeValue(SIMD3<Float>(0, 0, 0)))

        var prev: NodeID = n0.id
        for x in 1...100 {
            let nx = graph.addNode(DimmingDemoNodeValue(SIMD3<Float>(Float(5 * x), 0, 0)))
            try! graph.addEdge(prev, nx.id, DimmingDemoEdgeValue())
            prev = nx.id
        }

        prev = n0.id
        for y in 1...100 {
            let ny = graph.addNode(DimmingDemoNodeValue(SIMD3<Float>(0, Float(10 * y), 0)))
            try! graph.addEdge(prev, ny.id, DimmingDemoEdgeValue())
            prev = ny.id
        }

        prev = n0.id
        for z in 1...100 {
            let nz = graph.addNode(DimmingDemoNodeValue(SIMD3<Float>(0, 0, Float(20 * z))))
            try! graph.addEdge(prev, nz.id, DimmingDemoEdgeValue())
            prev = nz.id
        }
    }
}

struct DimmingDemoNodeValue: RenderableNodeValue {

    static let white = SIMD4<Float>(1, 1, 1, 1)

    var hidden: Bool { return false }

    var color: SIMD4<Float>? { return DimmingDemoNodeValue.white }

    var location: SIMD3<Float>

    init(_ location: SIMD3<Float>) {
        self.location = location
    }
}

struct DimmingDemoEdgeValue: RenderableEdgeValue {

    var hidden: Bool { return false }

}

typealias DimmingDemoGraph = BaseGraph<DimmingDemoNodeValue, DimmingDemoEdgeValue>

