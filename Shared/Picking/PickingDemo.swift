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

class PickingDemo: ObservableObject, Demo, TapHandler {

    static var nodeColorDefault = SIMD4<Float>(0, 0, 0, 1)

    static var locationDefault = SIMD3<Float>(1, 0.2, 3)

    var type: DemoType { return .picking }

    var info: String { return "Demonstrates node selection and editing" }

    var controlsView: some View {
        PickingDemoControls(demo: self)
    }

    var figureView: some View {
        PickingDemoFigure(demo: self)
    }

    @Published var selection = SelectionProperties()

    var tapRadius: Float = 0.05

    var graph: PickingDemoGraph

    var povController: CenteredPOVController

    var fovController: PerspectiveFOVController

    var renderer: Renderer

    var wireframe: ColoredNodeWireframe

    var generator: ColoredNodeWireframe.UpdateGenerator

    init() {
        self.graph = GraphBuilder(PickingDemoNodeValue.init)
            .simpleOctahedron()

        self.povController = CenteredPOVController(location: Self.locationDefault, 
                                                   orbitEnabled: false)
        self.fovController = PerspectiveFOVController()
        self.wireframe = ColoredNodeWireframe(nodeSize: 2)
        self.renderer = Renderer(povController, fovController, wireframe)
        self.generator = ColoredNodeWireframe.UpdateGenerator()

        wireframe.addUpdate(generator.makeUpdate(graph))

    }

    func updateFigure(nodePositionChanged: Bool = false,
                      nodeColorChanged: Bool = false) {
        generator.graphHasChanged(graph, nodePositions: nodePositionChanged, nodeColors: nodeColorChanged)
        wireframe.addUpdate(generator.makeUpdate(graph))
    }
    
    func resetGraph() {
        selection.clear()
        graph = GraphBuilder(PickingDemoNodeValue.init)
            .simpleOctahedron()
        wireframe.addUpdate(generator.makeUpdate(graph))
    }

    func tap(at touchLocation: SIMD2<Float>) {
        print("PickingDemo.tap. location: \(touchLocation.prettyString)")

        let pointSize = wireframe.makePointSize(povController.pov.location)

        // How much to enlarge touch size by, so that we accept a near miss.
        let fudgeFactor: Float = 1

        // The factor of 2 is b/c view size is 2 in clip space
        let touchSize = SIMD2<Float>(
            2 * fudgeFactor * pointSize  / Float(renderer.viewBounds.width),
            2 * fudgeFactor * pointSize / Float(renderer.viewBounds.height))

        //        print("PickingDemo.anyTap:    nodeSize = \(nodeSize)")
        //        print("PickingDemo.anyTap:    viewSize = \(renderController.fovController.viewSize)")
        //        print("PickingDemo.anyTap:    touchSize= \(touchSize.prettyString)")

        let touchRay = renderer.touchRay(at: touchLocation, size: touchSize)

        //        print("PickingDemo.anyTap:    touchRay: \(touchRay)")

        selection.copyFrom(graph.pickNode(touchRay))
    }

    func setColorScheme(_ colorScheme: ColorScheme) {
        renderer.setColorScheme(colorScheme)
    }

}

struct SelectionProperties {

    var nodeNumber: Int? = nil

    var group: Int = 0

    var location: SIMD3<Float> = .zero

    var name: String {
        if let nodeNumber {
            return "\(nodeNumber)"
        }
        else {
            return ""
        }
    }

    mutating func copyFrom(_ node: PickingDemoNode?) {
        guard let node = node
        else {
            self.clear()
            return
        }

        self.nodeNumber = node.nodeNumber

        if let value = node.value {
            self.group = value.group
            self.location = value.location
        }
        else {
            self.group = 0
            self.location = .zero
        }
    }

    mutating func clear() {
        self.nodeNumber = nil
        self.group = 0
        self.location = .zero
    }
}

