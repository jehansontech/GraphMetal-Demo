//
//  MonochromeSettingsDemo.swift
//  GraphMetal-Demo
//
//  Created by Jim Hanson on 8/10/24.
//

import SwiftUI
import GenericGraph
import GraphMetal
import Wacoma

fileprivate func makeEdgeValue() -> Void? {
    return nil
}

class MonochromeSettingsDemo: ObservableObject, Demo {

    static var defaultOrbitEnabled: Bool = true

    static var defaultOrbitSpeed: Float = .pi/30

    static var initialPointSize: Float  = ZWireframeConstants.pointSizeMinimum

    static var defaultFadeoutMidpoint: Float = 10

    static var defaultFadeoutDistance: Float = 8

    static let graphColor = SIMD4<Float>(1, 0, 0.5, 1)

    static let initialPOV = CenteredPOV(location: SIMD3<Float>(30, 0, -120))

    static let defaultPOV = CenteredPOV(location: SIMD3<Float>(10, 0, -10))

    var type: DemoType { .monochrome }

    var info: String { "Settings for Monochrome Wirefames" }

    var controlsView: some View {
        MonochromeSettingsControls(demo: self)
    }

    var figureView: some View {
        MonochromeSettingsFigure(demo: self)
    }

    var graph: MonochromeSettingsGraph

    var povController: OrbitingPOVController

    var fovController: PerspectiveFOVController

    var wireframe: MonochromeWireframe

    var renderer: ZRenderer

    init() {
        self.graph = GraphBuilder(MonochromeSettingsNodeValue.init, makeEdgeValue)
            .fancyCube(divisions: 2)

        self.povController = OrbitingPOVController(pov: Self.initialPOV,
                                                   orbitEnabled: Self.defaultOrbitEnabled,
                                                   orbitSpeed: Self.defaultOrbitSpeed)
        self.fovController = PerspectiveFOVController(fadeoutMidpoint: Self.defaultFadeoutMidpoint,
                                                      fadeoutDistance: Self.defaultFadeoutDistance)

        self.wireframe = MonochromeWireframe(nodeShape: .disc,
                                             nodeSize: MonochromeSettingsDemo.initialPointSize)

        self.renderer = ZRenderer(povController, fovController, wireframe)

        wireframe.addUpdate(.makeTotalUpdate(self.graph))
        povController.fly(to: Self.defaultPOV)
    }

    func setColorScheme(_ colorScheme: ColorScheme) {
        renderer.setColorScheme(colorScheme)
    }

}
