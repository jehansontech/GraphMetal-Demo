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

    var povController: OrbitingPOVController

    var fovController: PerspectiveFOVController

    var renderController: RenderController

    var wireframe: Wireframe

    var generator = WireframeUpdateGenerator()

    init() {
        self.graph = GraphBuilder(PickingDemoNodeValue.init, PickingDemoEdgeValue.init).simpleOctahedron()
        self.povController = OrbitingPOVController(pov: CenteredPOV(location: Self.locationDefault), orbitEnabled: false)
        self.fovController = PerspectiveFOVController()
        self.renderController = RenderController(povController, fovController)
        self.wireframe = Wireframe(settings: WireframeSettings(nodeColorDefault: Self.nodeColorDefault),
                                   nodePositionBufferIndex: 1,
                                   nodeColorBufferIndex: 2)

        renderController.renderables.append(wireframe)
        updateFigure(.all)
    }

    func updateFigure(_ change: RenderableGraphChange) {
        wireframe.addBufferUpdate(generator.makeUpdate(graph, change))
    }
    
    func resetGraph() {
        selection.clear()
        graph = GraphBuilder(PickingDemoNodeValue.init, PickingDemoEdgeValue.init)
            .simpleOctahedron()
        updateFigure(.all)
    }

    func primaryTap(at touchLocation: SIMD2<Float>) {
        anyTap(at: touchLocation)
    }

    func secondaryTap(at touchLocation: SIMD2<Float>) {
        anyTap(at: touchLocation)
    }

    private func anyTap(at touchLocation: SIMD2<Float>) {
        print("PickingDemo.anyTap: tap at \(touchLocation.prettyString)")


        let mysteriousFudgeFactor: Float = 10
        let nodeSize = wireframe.settings.getNodeSize(forPOV: renderController.povController.pov,
                                                      bbox: graph.makeBoundingBox())
        let touchRadius: Float = mysteriousFudgeFactor * Float(nodeSize) / Float(renderController.fovController.viewSize.width)

        print("PickingDemo.anyTap:    nodeSize = \(nodeSize)")
        print("PickingDemo.anyTap:    viewSize = \(renderController.fovController.viewSize)")
        print("PickingDemo.anyTap:    touchRadius = \(touchRadius)")

        let touchRay = renderController.touchRay(at: touchLocation, touchRadius: touchRadius)
        print("PickingDemo.anyTap:    touchRay: \(touchRay)")
        if let node = graph.pickNode(touchRay) {
            selection.copyFrom(node)
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

    var location: SIMD3<Float> = .zero

    var name: String {
        if let nodeID = id {
            return "\(nodeID)"
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

        self.id = node.id

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
        self.id = nil
        self.group = 0
        self.location = .zero
    }
}

