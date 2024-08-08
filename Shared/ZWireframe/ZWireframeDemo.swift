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

    static var defaultOrbitEnabled: Bool = true

    static var defaultOrbitSpeed: Float = .pi/30

    static var defaultFadeoutMidpoint: Float = 10

    static var defaultFadeoutDistance: Float = 8

    static let graphColor = SIMD4<Float>(1, 0, 0.5, 1)

    static var initialPOV = CenteredPOV(location: SIMD3<Float>(30, 0, -120))

    static var defaultPOV = CenteredPOV(location: SIMD3<Float>(10, 0, -10))

    var type: DemoType { .wireframe2 }

    var info: String { "New rendering engine" }

    var controlsView: some View {
        ZWireframeControls(demo: self)
    }

    var figureView: some View {
        ZWireframeFigure(demo: self)
    }

    var graph: ZWireframeGraph

    var povController: OrbitingPOVController

    var fovController: PerspectiveFOVController

    var wireframe: MonochromeWireframe

    var renderer: ZRenderer

    init() {
        self.graph = GraphBuilder(ZWireframeNodeValue.init, ZWireframeEdgeValue.init)
            .fancyCube(divisions: 2)

        self.povController = OrbitingPOVController(pov: Self.initialPOV,
                                                   orbitEnabled: Self.defaultOrbitEnabled,
                                                   orbitSpeed: Self.defaultOrbitSpeed)
        self.fovController = PerspectiveFOVController(fadeoutMidpoint: Self.defaultFadeoutMidpoint,
                                                      fadeoutDistance: Self.defaultFadeoutDistance)
        self.wireframe = MonochromeWireframe()

        self.renderer = ZRenderer(povController, fovController, wireframe)

        wireframe.addUpdate(.makeTotalUpdate(self.graph))
        povController.fly(to: Self.defaultPOV)
    }

    func setColorScheme(_ colorScheme: ColorScheme) {
        renderer.setColorScheme(colorScheme)
    }


}
