//
//  MonochromeDemo.swift
//  GraphMetal-Demo
//
//  Created by Jim Hanson on 8/10/24.
//

import SwiftUI
import GenericGraph
import GraphMetal
import Wacoma

class MonochromeDemo: ObservableObject, Demo {

    static var defaultOrbitEnabled: Bool = true

    static var defaultOrbitSpeed: Float = .pi/30

    static var initialNodeSize: Float  = 4

    static var defaultFadeoutMidpoint: Float = 10

    static var defaultFadeoutDistance: Float = 8

    static let graphColor = SIMD4<Float>(1, 0, 0.5, 1)

    static let initialPOV = CenteredPOV(location: SIMD3<Float>(30, 0, -120))

    static let defaultPOV = CenteredPOV(location: SIMD3<Float>(10, 0, -10))

    var type: DemoType { .monochrome }

    var info: String { "Settings for monochrome rendering" }

    var controlsView: some View {
        MonochromeControls(demo: self)
    }

    var figureView: some View {
        MonochromeFigure(demo: self)
    }

    var graph: MonochromeGraph

    var povController: OrbitingPOVController

    var fovController: PerspectiveFOVController

    var wireframe: ZMonochromeWireframe

    var renderer: ZRenderer

    init() {
        self.graph = GraphBuilder(MonochromeNodeValue.init)
            .fancyCube(divisions: 2)

        self.povController = OrbitingPOVController(pov: Self.initialPOV,
                                                   orbitEnabled: Self.defaultOrbitEnabled,
                                                   orbitSpeed: Self.defaultOrbitSpeed)
        self.fovController = PerspectiveFOVController(fadeoutMidpoint: Self.defaultFadeoutMidpoint,
                                                      fadeoutDistance: Self.defaultFadeoutDistance)

        self.wireframe = ZMonochromeWireframe(nodeShape: .disc,
                                              nodeSize: MonochromeDemo.initialNodeSize)

        self.renderer = ZRenderer(povController, fovController, wireframe)

        var updateGenerator = ZMonochromeWireframe.UpdateGenerator()
        wireframe.addUpdate(updateGenerator.makeUpdate(graph))
        povController.fly(to: Self.defaultPOV)
    }

    func setColorScheme(_ colorScheme: ColorScheme) {
        renderer.setColorScheme(colorScheme)
    }

}
