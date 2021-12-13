//
//  WireframeDemo.swift
//  GraphMetal-Demo
//
//  Created by Jim Hanson on 12/13/21.
//

import SwiftUI
import Wacoma
import GenericGraph
import GraphMetal

class WireframeDemo: RenderableGraphHolder {

    var graph: WireframeDemoGraph

    var povController: POVController

    var wireframeSettings: GraphWireframeSettings

    init() {
        self.graph = WireframeDemoGraph()
        self.povController = POVController(pov: POV(location: SIMD3<Float>(2, 0, 3)))
        self.wireframeSettings = GraphWireframeSettings()

        CubeBuilder(nodeValueFactory: WireframeDemoNodeValue.init,
                    edgeValueFactory: WireframeDemoEdgeValue.init)
            .addCube(to: graph)
    }

    func updateGraph() {
        fireGraphChange(RenderableGraphChange(nodeColors: true))
    }
}
