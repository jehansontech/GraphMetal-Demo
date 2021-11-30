//
//  CubeDemo.swift
//  GraphMetal-Demo
//
//  Created by Jim Hanson on 4/27/21.
//

import SwiftUI
// import Combine
import GenericGraph
import GraphMetal
import Wacoma

class CubeDemo: ObservableObject, RenderableGraphHolder {

    typealias GraphType = CubeDemoGraph

    var built: Bool = false

    var graph: CubeDemoGraph

    var povController: POVController

    @Published var rendererSettings = RendererSettings(nodeSizeAutomatic: false)

    @Published var red: Double = 0 {
        didSet {
            updateColors()
        }
    }

    @Published var green: Double = 0 {
        didSet {
            updateColors()
        }
    }

    @Published var blue: Double = 0 {
        didSet {
            updateColors()
        }
    }

    init() {
        self.graph = CubeDemoGraph()
        self.povController = POVController()
    }

    func setup() {
        if !built {
            built = true
            buildCube()
            afterBuild()
        }
    }

    func teardown() {
    }

    func groupColor(_ group: Int) -> SIMD4<Float>? {
        switch group % 8 {
        case 0:
            return SIMD4<Float>(Float(red), Float(green), Float(blue), 1)
        case 1:
            return SIMD4<Float>(Float(red), Float(green), Float(1 - blue), 1)
        case 2:
            return SIMD4<Float>(Float(red), Float(1 - green), Float(blue), 1)
        case 3:
            return SIMD4<Float>(Float(red), Float(1 - green), Float(1 - blue), 1)
        case 4:
            return SIMD4<Float>(Float(1 - red), Float(green), Float(blue), 1)
        case 5:
            return SIMD4<Float>(Float(1 - red), Float(green), Float(1 - blue), 1)
        case 6:
            return SIMD4<Float>(Float(1 - red), Float(1 - green), Float(blue), 1)
        case 7:
            return SIMD4<Float>(Float(1 - red), Float(1 - green), Float(1 - blue), 1)
        default:
            return nil
        }
    }

    func buildCube() {

        print("CubeDemo: building graph")

        let n0 = graph.addNode(CubeDemoNodeValue(SIMD3<Float>(-1, -1, -1), 1, self))
        let n1 = graph.addNode(CubeDemoNodeValue(SIMD3<Float>(-1, -1,  1), 2, self))
        let n2 = graph.addNode(CubeDemoNodeValue(SIMD3<Float>(-1,  1,  1), 3, self))
        let n3 = graph.addNode(CubeDemoNodeValue(SIMD3<Float>(-1,  1, -1), 4, self))
        let n4 = graph.addNode(CubeDemoNodeValue(SIMD3<Float>( 1, -1, -1), 5, self))
        let n5 = graph.addNode(CubeDemoNodeValue(SIMD3<Float>( 1, -1,  1), 6, self))
        let n6 = graph.addNode(CubeDemoNodeValue(SIMD3<Float>( 1,  1,  1), 7, self))
        let n7 = graph.addNode(CubeDemoNodeValue(SIMD3<Float>( 1,  1, -1), 8, self))

        try! graph.addEdge(n0.id, n1.id, CubeDemoEdgeValue())
        try! graph.addEdge(n1.id, n2.id, CubeDemoEdgeValue())
        try! graph.addEdge(n2.id, n3.id, CubeDemoEdgeValue())
        try! graph.addEdge(n3.id, n0.id, CubeDemoEdgeValue())

        try! graph.addEdge(n4.id, n5.id, CubeDemoEdgeValue())
        try! graph.addEdge(n5.id, n6.id, CubeDemoEdgeValue())
        try! graph.addEdge(n6.id, n7.id, CubeDemoEdgeValue())
        try! graph.addEdge(n7.id, n4.id, CubeDemoEdgeValue())

        try! graph.addEdge(n0.id, n4.id, CubeDemoEdgeValue())
        try! graph.addEdge(n1.id, n5.id, CubeDemoEdgeValue())
        try! graph.addEdge(n2.id, n6.id, CubeDemoEdgeValue())
        try! graph.addEdge(n3.id, n7.id, CubeDemoEdgeValue())

        fireGraphChange(RenderableGraphChange.ALL)
    }

    func afterBuild() {
        povController.pov = POV(
            location: SIMD3<Float>(-20, -30, -35),
            center:   SIMD3<Float>(  0,   0,   0),
            up:       SIMD3<Float>(  0,   1,   0)
        )
        povController.povDefault = POV(
            location: SIMD3<Float>(-2, -3, -3.5),
            center:   SIMD3<Float>( 0,  0,  0),
            up:       SIMD3<Float>( 0,  1,  0)
        )

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.povController.goToDefaultPOV()
        }
    }

    private func updateColors() {
        fireGraphChange(RenderableGraphChange(nodeColors: true))
    }
}

struct CubeDemoNodeValue: RenderableNodeValue {

    var hidden: Bool { return false }

    var location: SIMD3<Float>

    var group: Int

    weak var cube: CubeDemo!

    var color: SIMD4<Float>? {
        return cube.groupColor(group)
    }

    init(_ location: SIMD3<Float>, _ group: Int, _ cube: CubeDemo) {
        self.location = location
        self.group = group
        self.cube = cube
    }

}

struct CubeDemoEdgeValue: RenderableEdgeValue {

    var hidden: Bool { return false }
}

typealias CubeDemoGraph = BaseGraph<CubeDemoNodeValue, CubeDemoEdgeValue>


