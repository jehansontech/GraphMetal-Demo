//
//  ZWireframeDemo.swift
//  GraphMetal-Demo
//
//  Created by Jim Hanson on 7/30/24.
//

import SwiftUI
import GenericGraph
import GraphMetal
import Wacoma

class ZWireframeDemo: ObservableObject, Demo {

    static var defaultPOV = CenteredPOV(location: SIMD3<Float>(10, 0, -48))

    static var defaultOrbitEnabled: Bool = true

    static var defaultOrbitSpeed: Float = .pi/30

    static var defaultFadeoutMidpoint: Float = 40

    static var defaultFadeoutDistance: Float = 40

    var type: DemoType { .wireframe2 }

    var info: String { "New rendering engine" }

    var controlsView: some View {
        Wireframe2Controls(demo: self)
    }

    var figureView: some View {
        Wireframe2Figure(demo: self)
    }

    var graph: ZWireframeGraph

    var povController: OrbitingPOVController

    var fovController: PerspectiveFOVController

    var renderController: ZRenderer

    init() {
        self.graph = GraphBuilder(ZWireframeNodeValue.init, ZWireframeEdgeValue.init)
            .fancyCube(divisions: 2)

        self.povController = OrbitingPOVController(pov: Self.defaultPOV,
                                                   orbitEnabled: Self.defaultOrbitEnabled,
                                                   orbitSpeed: Self.defaultOrbitSpeed)
        self.fovController = PerspectiveFOVController(fadeoutMidpoint: Self.defaultFadeoutMidpoint,
                                                      fadeoutDistance: Self.defaultFadeoutDistance)
        self.renderController = ZRenderer(povController, fovController)

        // renderController.wireframe.addBufferUpdate(ZWireframeUpdate.makeTotalUpdate(self.graph))
    }

    func setColorScheme(_ colorScheme: ColorScheme) {
        renderController.setColorScheme(colorScheme)
    }


}
