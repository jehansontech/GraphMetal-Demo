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

    static var initialPOV = CenteredPOV(location: SIMD3<Float>(30, 0, -120))

    static var defaultPOV = CenteredPOV(location: SIMD3<Float>(10, 0, -48))

    var type: DemoType { return .cube }

    var info: String { return "Demonstrates orbit, fadeout, and changing the point of view" }

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

    var renderController: RenderController

    var wireframe: Wireframe

    init() {
        self.graph = GraphBuilder(CubeDemoNodeValue.init, CubeDemoEdgeValue.init)
            .fancyCube(divisions: 5)

        self.povController = OrbitingPOVController(pov: Self.defaultPOV,
                                                   orbitEnabled: false,
                                                   orbitSpeed: Self.defaultOrbitSpeed)
        self.fovController = PerspectiveFOVController(fadeoutMidpoint: Self.defaultFadeoutMidpoint,
                                                      fadeoutDistance: Self.defaultFadeoutDistance)
        self.renderController = RenderController(povController, fovController)
        self.wireframe = Wireframe(WireframeSettings(edgeColor: Self.graphColor))

        renderController.renderables.append(wireframe)
        povController.jumpTo(pov: Self.initialPOV)
        wireframe.addBufferUpdate(Self.makeBufferUpdate(self.graph))
    }


    func present() {
        if needsPresentation {
            needsPresentation = false
            povController.flyToDefault() {
                self.povController.orbitEnabled = Self.defaultOrbitEnabled
            }
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

    private static func makeBufferUpdate(_ graph: CubeDemoGraph) -> WireframeUpdate2? {
        var generator = WireframeUpdateGenerator2()
        return generator.makeUpdate(graph, .all)
    }
}

