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

    static var graphColor = SIMD4<Float>(1,0,1,1)
    
    var graph: CubeDemoGraph

    var povController: POVController

    var renderController: RenderController

    var wireframeSettings: GraphWireframeSettings

    var built = false

    init() {
        self.graph = CubeDemoGraph()
        self.povController = POVController(pov: POV(location: SIMD3<Float>(40, 20, 60)),
                                           orbitEnabled: true)
        self.renderController = RenderController(fadeoutOnset: 40,
                                                 fadeoutDistance: 50)
        self.wireframeSettings = GraphWireframeSettings(edgeColor: Self.graphColor)

        CubeBuilder(divisions: 5, nodeValueFactory: CubeDemoNodeValue.init,
                    edgeValueFactory: CubeDemoEdgeValue.init)
            .addCube(to: graph)
    }

}

