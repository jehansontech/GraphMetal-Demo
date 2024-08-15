//
//  OldWireframeDemo.swift
//  GraphMetal-Demo
//
//  Created by Jim Hanson on 8/15/24.
//

import SwiftUI
import GenericGraph
import GraphMetal
import Wacoma

class OldWireframeDemo: ObservableObject, Demo {

    static var defaultOrbitEnabled: Bool = true

    static var defaultOrbitSpeed: Float = .pi/30

    static var initialPointSize: Float  = ZWireframeConstants.pointSizeMinimum

    static var defaultFadeoutMidpoint: Float = 4

    static var defaultFadeoutDistance: Float = 8

    static let defaultEdgeColor = SIMD4<Float>(1, 0, 0.5, 1)

    static var initialPOV = CenteredPOV(location: SIMD3<Float>(10, 0, -10))

    static var defaultPOV = CenteredPOV(location: SIMD3<Float>(4, 0, -4))

    var type: DemoType { .oldWireframe }

    var info: String { "" }

    var controlsView: some View {
        OldWireframeControls(demo: self)
    }

    var figureView: some View {
        OldWireframeFigure(demo: self)
    }

    var graph: OldWireframeGraph

    var povController: OrbitingPOVController

    var fovController: PerspectiveFOVController

    var wireframe: Wireframe

    var renderer: RenderController

    init() {
        self.graph = GraphBuilder(OldWireframeNodeValue.init, OldWireframeEdgeValue.init)
            .simpleCube()

        self.povController = OrbitingPOVController(pov: Self.initialPOV,
                                                   orbitEnabled: Self.defaultOrbitEnabled,
                                                   orbitSpeed: Self.defaultOrbitSpeed)
        self.fovController = PerspectiveFOVController(fadeoutMidpoint: Self.defaultFadeoutMidpoint,
                                                      fadeoutDistance: Self.defaultFadeoutDistance)

        self.wireframe = Wireframe(nodePositionBufferIndex: 1,
                                   nodeColorBufferIndex: 2)


        self.renderer = RenderController(povController, fovController)

        //        self.wireframe.nodeSize = OldWireframeDemo.initialPointSize
        //        wireframe.addUpdate(.makeTotalUpdate(self.graph))

        renderer.renderables.append(wireframe)
        povController.fly(to: Self.defaultPOV)
    }

    func setColorScheme(_ colorScheme: ColorScheme) {
        renderer.setColorScheme(colorScheme)
    }

}
