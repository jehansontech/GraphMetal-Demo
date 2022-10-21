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

class SettingsDemo: ObservableObject, Demo {

    nonisolated static let initialPOV = CenteredPOV(location: SIMD3<Float>(2.5, 0, -4))

    nonisolated static let initialZNear: Float = 0.001

    nonisolated static let initialZFar: Float = 1000

    nonisolated static let initialYFOV: Float = .piOverTwo

    nonisolated static let initialGraphColor = SIMD4<Float>(0.2, 0.2, 0.2, 1)

    nonisolated var type: DemoType { return .appearance }

    nonisolated var info: String { return "Previews configuration settings affecting the graph's appearance" }

    var controlsView: some View {
        SettingsDemoControls(demo: self)
    }

    var figureView: some View {
        SettingsDemoFigure(demo: self)
    }

    var graph: SettingsDemoGraph

    var renderController: RenderController

    var povController: OrbitingPOVController

    var fovController: PerspectiveFOVController

    var wireframe: Wireframe

    var generator = WireframeUpdateGenerator2()

    init() {
        self.graph = GraphBuilder(SettingsDemoNodeValue.init, SettingsDemoEdgeValue.init)
            .simpleCube()
        self.povController = OrbitingPOVController(pov: Self.initialPOV, orbitEnabled: false)
        self.fovController = PerspectiveFOVController(zNear: Self.initialZNear, zFar: Self.initialZFar, yFOV: Self.initialYFOV)
        self.renderController = RenderController(povController, fovController)

        self.wireframe = Wireframe(WireframeSettings(nodeSizeIsAdjusted: false,
                                                      nodeColorDefault: Self.initialGraphColor,
                                                      edgeColor: Self.initialGraphColor))

        wireframe.addBufferUpdate(makeBufferUpdate(.all))

        renderController.renderables.append(wireframe)
    }

    func updateGraph(_ change: RenderableGraphChange) {
        wireframe.addBufferUpdate(makeBufferUpdate(change))

    }

    func resetAll() {
        wireframe.settings.reset()
        fovController.zNear = Self.initialZNear
        fovController.zFar = Self.initialZFar
        fovController.yFOV = Self.initialYFOV
    }

    private func makeBufferUpdate(_ change: RenderableGraphChange) -> WireframeUpdate2? {
        return generator.makeUpdate(graph, change)
    }

}
