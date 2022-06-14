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

class CubeDemo: ObservableObject, RenderableGraphContainer, Demo {

    static var defaultOrbitEnabled: Bool = true
    
    static var defaultOrbitSpeed: Float = .pi/30

    static var defaultFadeoutOnset: Float = 40

    static var defaultFadeoutDistance: Float = 40

    static var graphColor = SIMD4<Float>(1, 0, 0.5, 1)

    static var initialPOV = CenteredPOV(location: SIMD3<Float>(30, 0, -120))

    static var defaultPOV = CenteredPOV(location: SIMD3<Float>(10, 0, -48))

    var graph: CubeDemoGraph

    var povController: OrbitingPOVController

    var fovController: PerspectiveFOVController

    var renderController: RenderController

    // var wireframeSettings: WireframeSettings

    var wireframe: Wireframe<CubeDemo>!

    var type: DemoType { return .cube }

    var info: String { return "Demonstrates orbit, fadeout, and changing the point of view" }

    @Published var needsPresentation = true

    init() {
        self.graph = GraphBuilder(CubeDemoNodeValue.init, CubeDemoEdgeValue.init)
            .fancyCube(divisions: 5)

        let povController = OrbitingPOVController(pov: Self.defaultPOV,
                                                   orbitEnabled: false,
                                                   orbitSpeed: Self.defaultOrbitSpeed)
        povController.jumpTo(pov: Self.initialPOV)
        // To avoid threading issue, make all mods BEFORE setting self.povController
        self.povController = povController

        self.fovController = PerspectiveFOVController(fadeoutOnset: Self.defaultFadeoutOnset,
                                                      fadeoutDistance: Self.defaultFadeoutDistance)

        self.renderController = RenderController(povController, fovController)

        self.wireframe = Wireframe(self)
        self.wireframe.settings.edgeColor = Self.graphColor
        self.renderController.renderables.append(wireframe)
    }


    func present() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) { [self] in
            // print("CubeDemo.present", "flight is starting! pov: \(povController.pov), center: \(povController.center.prettyString)")
            povController.flyToDefault() {
                // print("CubeDemo.present", "flight is complete! pov: \(povController.pov), center: \(povController.center.prettyString)")
                self.povController.orbitEnabled = Self.defaultOrbitEnabled
                self.needsPresentation = false
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

}

