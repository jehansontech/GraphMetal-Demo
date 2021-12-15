//
//  VisibilityDemo.swift
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

    var info: String { return "Demonstrates rotation, fadeout, and controlling the point of view" }

    var povControllerUsage: [(String, String)] = [
        ("Drag", "Moves the figure around, keeping it centered on the same point"),
        ("Pinch", "Moves the toward or away from the center point"),
        ("Rotate", "Changes the 'up' direction")
    ]

    var labelWidth: CGFloat = 80
    
    @Published var needsPresentation = true

    init() {
        self.graph = CubeDemoGraph()
        self.povController = POVController(pov: Self.initialPOV,
                                           povDefault: Self.presentationPOV,
                                           orbitEnabled: false)
        self.renderController = RenderController(fadeoutOnset: 50,
                                                 fadeoutDistance: 50)
        self.wireframeSettings = GraphWireframeSettings(edgeColor: Self.graphColor)

        GraphBuilder(divisions: 5, nodeValueFactory: CubeDemoNodeValue.init,
                    edgeValueFactory: CubeDemoEdgeValue.init)
            .addCube(to: graph)
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

