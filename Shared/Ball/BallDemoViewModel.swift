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

    var renderController: RenderController

    var povController = OrbitingPOVController(pov: CenteredPOV(location: SIMD3<Float>(0, 0, -2)))

    var fovController = PerspectiveFOVController()

    private var wireframe: Wireframe

    private var runner: BallDemoRunner

    init() {
        self.renderController = RenderController(povController, PerspectiveFOVController())
        self.wireframe = Wireframe(nodePositionBufferIndex: 1,
                                   nodeColorBufferIndex: 2)
        self.runner = BallDemoRunner()

        self.renderController.renderables.append(wireframe)
        Task {
            await runner.connect(self)
        }
    }

    func setColorScheme(_ colorScheme: ColorScheme) {
        switch colorScheme {
        case .dark:
            renderController.backgroundColor = RenderController.defaultDarkBackground
            break
        case .light:
            renderController.backgroundColor = RenderController.defaultLightBackground
            break
        @unknown default:
            break
        }
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

    func applyUpdate(_ update: StepResult) async {
        self.nodeCount = update.nodeCount
        self.edgeCount = update.edgeCount
        wireframe.addBufferUpdate(update.wireframeUpdate)
    }
}
