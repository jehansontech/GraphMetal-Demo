//
//  PickingDemo.swift
//  GraphMetal-Demo
//
//  Created by Jim Hanson on 12/15/21.
//

import SwiftUI
import GenericGraph
import GraphMetal
import Wacoma

class PickingDemo: ObservableObject, RenderableGraphContainer, Demo, TapHandler {

    static var nodeColorDefault = SIMD4<Float>(0, 0, 0, 1)

    static var locationDefault = SIMD3<Float>(1, 0.2, 3)

    var graph: PickingDemoGraph

    var povController: OrbitingPOVController

    var fovController: PerspectiveFOVController

    var renderController: RenderController

    var wireframe: Wireframe<PickingDemo>!

    var type: DemoType { return .picking }

    var info: String { return "Demonstrates node selection and editing" }

    @Published var selection = SelectionProperties()

    init() {
        self.graph = GraphBuilder(PickingDemoNodeValue.init, PickingDemoEdgeValue.init).simpleOctahedron()
        self.povController = OrbitingPOVController(pov: CenteredPOV(location: Self.locationDefault), orbitEnabled: false)
        self.fovController = PerspectiveFOVController()
        self.renderController = RenderController(povController, fovController)
        self.wireframe = Wireframe(self) //, WireframeSettings(nodeColorDefault: Self.nodeColorDefault))

        renderController.renderables.append(wireframe)
    }

    func resetGraph() {
        selection.clear()
        graph = GraphBuilder(PickingDemoNodeValue.init, PickingDemoEdgeValue.init)
            .simpleOctahedron()
        fireGraphChange(RenderableGraphChange(nodes: true, edges: true))
    }

    func tap(at location: SIMD2<Float>, mode: GestureMode) {
        print("Tap at \(location.prettyString)")
        if let nodeID = wireframe.findNearestNode(location,
                                                  self.povController,
                                                  self.fovController) {
            selection.copyFrom(graph.nodes[nodeID])
        }
    }

    func setColorScheme(_ colorScheme: ColorScheme) {
        switch colorScheme {
        case .dark:
            renderController.backgroundColor = RenderController.defaultDarkBackground
            break
        case .light:
            renderController.backgroundColor = RenderController.defaultLightBackground
            break
        @unknown default:
            break
        }
    }

}

struct SelectionProperties {

    var id: NodeID? = nil

    var group: Int = 0

    var x: Float = 0

    var y: Float = 0

    var z: Float = 0

    var name: String {
        if let nodeID = id {
            return "\(nodeID)"
        }
        else {
            return ""
        }
    }

    var location: SIMD3<Float> {
        return SIMD3<Float>(x: x, y: y, z: z)
    }

    mutating func copyFrom(_ node: PickingDemoNode?) {
        guard let node = node
        else {
            self.clear()
            return
        }

        self.id = node.id

        if let value = node.value {
            self.group = value.group
            self.x = value.location.x
            self.y = value.location.y
            self.z = value.location.z
        }
        else {
            self.group = 0
            self.x = 0
            self.y = 0
            self.z = 0
        }
    }

    mutating func clear() {
        self.id = nil
        self.group = 0
        self.x = 0
        self.y = 0
        self.z = 0
    }
}

