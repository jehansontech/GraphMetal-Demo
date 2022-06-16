//
//  SettingsDemo.swift
//  GraphMetal-Demo
//
//  Created by Jim Hanson on 12/13/21.
//

import SwiftUI
import Wacoma
import GenericGraph
import GraphMetal

class SettingsDemo: ObservableObject, RenderableGraphContainer, Demo {

    static var initialPOV = CenteredPOV(location: SIMD3<Float>(2.5, 0, -4))

    static var initialZNear: Float = 0.001

    static var initialZFar: Float = 1000

    static var initialYFOV: Float = .piOverTwo

    static var initialGraphColor = SIMD4<Float>(0.2, 0.2, 0.2, 1)

    var graph: SettingsDemoGraph

    var renderController: RenderController

    var povController: OrbitingPOVController

    var fovController: PerspectiveFOVController

    // var wireframeSettings: WireframeSettings

    var wireframe: Wireframe<SettingsDemo>!

    var type: DemoType { return .appearance }

    var info: String { return "Previews configuration settings affecting the graph's appearance" }
    init() {
        self.graph = GraphBuilder(SettingsDemoNodeValue.init, SettingsDemoEdgeValue.init)
            .simpleCube()
        self.povController = OrbitingPOVController(pov: Self.initialPOV, orbitEnabled: false)
        self.fovController = PerspectiveFOVController(zNear: Self.initialZNear, zFar: Self.initialZFar, yFOV: Self.initialYFOV)
        self.renderController = RenderController(povController, fovController)

        self.wireframe = Wireframe(self, WireframeSettings(nodeSizeIsAdjusted: false,
                                                           nodeColorDefault: Self.initialGraphColor,
                                                           edgeColor: Self.initialGraphColor))
        renderController.renderables.append(wireframe)
    }

    func resetAll() {
        wireframe.settings.reset()
        fovController.zNear = Self.initialZNear
        fovController.zFar = Self.initialZFar
        fovController.yFOV = Self.initialYFOV
    }
    func updateGraph() {
        fireGraphChange(RenderableGraphChange(nodeColors: true))
    }
}
