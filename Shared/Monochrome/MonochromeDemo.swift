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

    static let initialLocation = SIMD3<Float>(30, 0, -120)

    static let defaultLocation = SIMD3<Float>(10, 0, -10)

    var type: DemoType { .monochrome }

    var info: String { "Settings for monochrome rendering" }

    var controlsView: some View {
        MonochromeControls(demo: self)
    }

    var figureView: some View {
        MonochromeFigure(demo: self)
    }

    var graph: MonochromeGraph

    var povController: CenteredPOVController

    var fovController: PerspectiveFOVController

    var wireframe: MonochromeWireframe

    var renderer: Renderer

    init() {
        self.graph = GraphBuilder(MonochromeNodeValue.init)
            .fancyCube(divisions: 2)

        self.povController = CenteredPOVController(location: Self.initialLocation,
                                                   orbitEnabled: Self.defaultOrbitEnabled,
                                                   orbitSpeed: Self.defaultOrbitSpeed)
        self.fovController = PerspectiveFOVController()

        self.wireframe = MonochromeWireframe(nodeShape: .disc,
                                              nodeSize: MonochromeDemo.initialNodeSize)

        self.renderer = Renderer(povController, fovController, wireframe)
        self.renderer.fadeoutDistance = Self.defaultFadeoutDistance
        self.renderer.fadeoutMidpoint = Self.defaultFadeoutMidpoint
        var updateGenerator = MonochromeWireframe.UpdateGenerator()
        wireframe.addUpdate(updateGenerator.makeUpdate(graph))
        povController.flyTo(location: Self.defaultLocation)
    }

    func setColorScheme(_ colorScheme: ColorScheme) {
        renderer.setColorScheme(colorScheme)
    }

}
