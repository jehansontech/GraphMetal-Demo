//
//  ColoredNodesDemo.swift
//  GraphMetal-Demo
//
//  Created by Jim Hanson on 7/30/24.
//

import SwiftUI
import GenericGraph
import GraphMetal
import Wacoma

class ColoredNodesDemo: ObservableObject, Demo {

    static var defaultOrbitEnabled: Bool = true

    static var defaultOrbitSpeed: Float = .pi/30

    static var initialPointSize: Float  = WireframeConstants.pointSizeMinimum

    static var defaultFadeoutMidpoint: Float = 4

    static var defaultFadeoutDistance: Float = 8

    static let defaultEdgeColor = SIMD4<Float>(1, 0, 0.5, 1)

    static var initialLocation = SIMD3<Float>(10, 0, -10)

    static var defaultLocation = SIMD3<Float>(4, 0, -4)

    var type: DemoType { .coloredNodes }

    var info: String { "Settings for rendering colored nodes" }

    var controlsView: some View {
        ColoredNodesControls(demo: self)
    }

    var figureView: some View {
        ColoredNodesFigure(demo: self)
    }

    var graph: ColoredNodesGraph

    var povController: CenteredPOVController

    var fovController: PerspectiveFOVController

    var wireframe: ColoredNodeWireframe

    var renderer: Renderer

    init() {
        self.graph = GraphBuilder(ColoredNodeValue.init)
            .simpleCube()

        self.povController = CenteredPOVController(location: Self.initialLocation,
                                                   orbitEnabled: Self.defaultOrbitEnabled,
                                                   orbitSpeed: Self.defaultOrbitSpeed)
        self.fovController = PerspectiveFOVController()

        self.wireframe = ColoredNodeWireframe(nodeShape: .disc, edgeColor: Self.defaultEdgeColor)

        self.wireframe.nodeSize = ColoredNodesDemo.initialPointSize

        self.renderer = Renderer(povController, fovController, wireframe)
        self.renderer.fadeoutDistance = Self.defaultFadeoutDistance
        self.renderer.fadeoutMidpoint = Self.defaultFadeoutMidpoint

        var updateGenerator = ColoredNodeWireframe.UpdateGenerator()
        wireframe.addUpdate(updateGenerator.makeUpdate(graph))
        povController.flyTo(location: Self.defaultLocation)
    }

    func setColorScheme(_ colorScheme: ColorScheme) {
        renderer.setColorScheme(colorScheme)
    }

}
