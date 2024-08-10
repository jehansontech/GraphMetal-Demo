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

fileprivate func makeEdgeValue() -> Void? {
    return nil
}

class ColoredNodesDemo: ObservableObject, Demo {

    static var defaultOrbitEnabled: Bool = true

    static var defaultOrbitSpeed: Float = .pi/30

    static var initialPointSize: Float  = ZWireframeConstants.pointSizeMinimum

    static var defaultFadeoutMidpoint: Float = 4

    static var defaultFadeoutDistance: Float = 8

    static let graphColor = SIMD4<Float>(1, 0, 0.5, 1)

    static var initialPOV = CenteredPOV(location: SIMD3<Float>(10, 0, -10))

    static var defaultPOV = CenteredPOV(location: SIMD3<Float>(4, 0, -4))

    var type: DemoType { .coloredNodes }

    var info: String { "Settings for Wireframe with colored nodes" }

    var controlsView: some View {
        ColoredNodesControls(demo: self)
    }

    var figureView: some View {
        ColoredNodesFigure(demo: self)
    }

    var graph: ColoredNodesGraph

    var povController: OrbitingPOVController

    var fovController: PerspectiveFOVController

    var wireframe: ZWireframeWithColoredNodes

    var renderer: ZRenderer

    init() {
        self.graph = GraphBuilder(ColoredNodeValue.init, makeEdgeValue)
            .simpleCube()

        self.povController = OrbitingPOVController(pov: Self.initialPOV,
                                                   orbitEnabled: Self.defaultOrbitEnabled,
                                                   orbitSpeed: Self.defaultOrbitSpeed)
        self.fovController = PerspectiveFOVController(fadeoutMidpoint: Self.defaultFadeoutMidpoint,
                                                      fadeoutDistance: Self.defaultFadeoutDistance)

        self.wireframe = ZWireframeWithColoredNodes(nodeShape: .disc)

        self.wireframe.nodeSize = ColoredNodesDemo.initialPointSize

        self.renderer = ZRenderer(povController, fovController, wireframe)

        wireframe.addUpdate(.makeTotalUpdate(self.graph))
        povController.fly(to: Self.defaultPOV)
    }

    func setColorScheme(_ colorScheme: ColorScheme) {
        renderer.setColorScheme(colorScheme)
    }

}
