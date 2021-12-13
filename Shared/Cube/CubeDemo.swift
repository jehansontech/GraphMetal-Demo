//
//  VisibilityDemo.swift
//  GraphMetal-Demo (iOS)
//
//  Created by Jim Hanson on 11/23/21.
//

import SwiftUI
import GenericGraph
import GraphMetal

class CubeDemo: ObservableObject, RenderableGraphHolder {

    static var graphColor = SIMD4<Float>(1,0,0.5,1)

    static var initialPOV = POV(location: SIMD3<Float>(80, 40, 120))

    static var presentationPOV = POV(location: SIMD3<Float>(40, 20, 60))

    var graph: CubeDemoGraph

    var povController: POVController

    var renderController: RenderController

    var wireframeSettings: GraphWireframeSettings

    @Published var needsPresentation = true

    init() {
        self.graph = CubeDemoGraph()
        self.povController = POVController(pov: Self.initialPOV,
                                           povDefault: Self.presentationPOV)
        self.renderController = RenderController(fadeoutOnset: 100,
                                                 fadeoutDistance: 50)
        self.wireframeSettings = GraphWireframeSettings(edgeColor: Self.graphColor)

        CubeBuilder(divisions: 5, nodeValueFactory: CubeDemoNodeValue.init,
                    edgeValueFactory: CubeDemoEdgeValue.init)
            .addCube(to: graph)
    }


    func present() {
            povController.goToDefaultPOV()
            povController.orbitEnabled = true
    }
}

