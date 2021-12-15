//
//  CubeDemo.swift
//  GraphMetal-Demo (iOS)
//
//  Created by Jim Hanson on 11/23/21.
//

import SwiftUI
import GenericGraph
import GraphMetal

class CubeDemo: ObservableObject, RenderableGraphContainer, Demo {

    static var graphColor = SIMD4<Float>(1,0,0.5,1)

    static var initialPOV = POV(location: SIMD3<Float>(80, 40, 120))

    static var presentationPOV = POV(location: SIMD3<Float>(40, 20, 60))

    var graph: CubeDemoGraph

    var povController: POVController

    var renderController: RenderController

    var wireframeSettings: GraphWireframeSettings

    var type: DemoType { return .cube }

    var info: String { return "Demonstrates rotation, fadeout, and moving around" }

    @Published var needsPresentation = true

    init() {
        self.graph = GraphBuilder(CubeDemoNodeValue.init, CubeDemoEdgeValue.init)
            .fancyCube(divisions: 5)
        self.povController = POVController(pov: Self.initialPOV,
                                           povDefault: Self.presentationPOV,
                                           orbitEnabled: false)
        self.renderController = RenderController(fadeoutOnset: 50,
                                                 fadeoutDistance: 50)
        self.wireframeSettings = GraphWireframeSettings(edgeColor: Self.graphColor)

    }


    func present() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) { [self] in
            povController.flyTo(Self.presentationPOV) {
                print("CubeDemo.present", "flight is complete!")
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) { [self] in
                    povController.orbitEnabled = true
                    needsPresentation = false
                }
            }
        }
    }
}

