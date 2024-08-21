//
//  BallDemoViewModel.swift
//  GraphMetal-Demo
//
//  Created by Jim Hanson on 10/5/22.
//

import SwiftUI
import GenericGraph
import GraphMetal
import Wacoma

@MainActor
class BallDemoViewModel: ObservableObject {

    @Published var nodeCount: Int = 0

    @Published var edgeCount: Int = 0

    var povController = OrbitingPOVController(pov: CenteredPOV(location: SIMD3<Float>(0, 0, -3)))

    var fovController = PerspectiveFOVController()

    var wireframe = ZWireframeWithColoredNodes(nodeSize: 1)

    var renderer: ZRenderer

    private var runner: BallDemoRunner

    init() {
        self.renderer = ZRenderer(povController, fovController, wireframe)
        self.runner = BallDemoRunner()
        Task {
            await runner.connect(self)
        }
    }

    func setColorScheme(_ colorScheme: ColorScheme) {
        renderer.setColorScheme(colorScheme)
    }

    func start() {
        Task.detached {
            await self.runner.start()
        }
    }

    func stop() {
        Task {
            await self.runner.stop()
        }
    }

    func reset() {
        Task {
            await self.runner.reset()
        }
    }

    func applyStepResult(_ stepResult: StepResult) async {
        self.nodeCount = stepResult.nodeCount
        self.edgeCount = stepResult.edgeCount
        if let wireframeUpdate = stepResult.wireframeUpdate {
            wireframe.addUpdate(wireframeUpdate)
        }
    }
}
