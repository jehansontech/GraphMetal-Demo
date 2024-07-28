//
//  Wireframe2DemoViewModel.swift
//  GraphMetal-Demo
//
//  Created by Jim Hanson on 7/12/24.
//

import SwiftUI
import GenericGraph
import GraphMetal
import Wacoma

@MainActor
class Wireframe2DemoViewModel: ObservableObject {

    var renderController: RenderController

    var povController = OrbitingPOVController(pov: CenteredPOV(location: SIMD3<Float>(0, 0, -2)))

    var fovController = PerspectiveFOVController()

    var wireframe: Wireframe2

    private var runner: Wireframe2DemoRunner!

    @Published
    public private(set) var isConnected = false

    init() {
        self.renderController = RenderController(povController, fovController)
        self.wireframe = Wireframe2(
                uniformsBufferIndex: 0,
                nodePositionBufferIndex: 1,
                nodeColorBufferIndex: 2,
                edgeColorBufferIndex: 3,
                settings: Wireframe2Settings())
        self.renderController.renderables.append(wireframe)
    }

    func connect(_ runner: Wireframe2DemoRunner) async {
        print("Wireframe2DemoViewModel.connect: entered")
        self.runner = runner
        await runner.finishConnecting(self)
        await Task.uncheckedSleep(seconds: 2)
        self.isConnected = true
        print("Wireframe2DemoViewModel.connect: exiting")
    }

    func setColorScheme(_ colorScheme: ColorScheme) {
        switch colorScheme {
        case .dark:
            renderController.backgroundColor = RenderConstants.defaultDarkBackground
            break
        case .light:
            renderController.backgroundColor = RenderConstants.defaultLightBackground
            break
        @unknown default:
            break
        }
    }
}
