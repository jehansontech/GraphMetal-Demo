//
//  CubeDemo.swift
//  GraphMetal-Demo
//
//  Created by Jim Hanson on 11/23/21.
//

import SwiftUI
import GenericGraph
import GraphMetal
import Wacoma

class CubeDemo: ObservableObject, Demo {

    static var defaultOrbitEnabled: Bool = true

    static var defaultOrbitSpeed: Float = .pi/30

    static var defaultFadeoutMidpoint: Float = 40

    static var defaultFadeoutDistance: Float = 40

    static let graphColor = SIMD4<Float>(1, 0, 0.5, 1)

    static let nodeSize: Float = 16

    static var initialPOV = CenteredPOV(location: SIMD3<Float>(30, 0, -120))

    static var defaultPOV = CenteredPOV(location: SIMD3<Float>(10, 0, -48))

    var type: DemoType { return .cube }

    var info: String { return "Demonstrates point of view settings and changes" }

    @Published var needsPresentation = true

    var controlsView: some View {
        CubeDemoControls(demo: self)
    }

    var figureView: some View {
        CubeDemoFigure(demo: self)
    }

    var graph: CubeDemoGraph

    var povController: OrbitingPOVController

    var fovController: PerspectiveFOVController

    var wireframe: MonochromeWireframe

    var renderer: Renderer

    init() {
        self.graph = GraphBuilder(CubeDemoNodeValue.init)
            .fancyCube(divisions: 5)

        self.povController = OrbitingPOVController(pov: Self.defaultPOV,
                                                   orbitEnabled: false,
                                                   orbitSpeed: Self.defaultOrbitSpeed)
        self.fovController = PerspectiveFOVController(fadeoutMidpoint: Self.defaultFadeoutMidpoint,
                                                      fadeoutDistance: Self.defaultFadeoutDistance)
        
        self.wireframe = MonochromeWireframe(nodeShape: .disc,
                                              nodeSize: Self.nodeSize,
                                              graphColor: Self.graphColor)

        self.renderer = Renderer(povController, fovController, wireframe)

        var updateGenerator = MonochromeWireframe.UpdateGenerator()
        wireframe.addUpdate(updateGenerator.makeUpdate(graph))
        povController.jumpTo(location: Self.initialPOV.location,
                             center: Self.initialPOV.center,
                             up: Self.initialPOV.up)
    }


    func present() {
        if needsPresentation {
            needsPresentation = false
            povController.fly(to: povController.defaultPOV)
            self.povController.orbitEnabled = Self.defaultOrbitEnabled
        }
    }

    func setColorScheme(_ colorScheme: ColorScheme) {
        renderer.setColorScheme(colorScheme)
    }
}
