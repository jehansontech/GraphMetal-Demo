//
//  AppearanceDemo.swift
//  GraphMetal-Demo
//
//  Created by Jim Hanson on 12/13/21.
//

import SwiftUI
import Wacoma
import GenericGraph
import GraphMetal

class AppearanceDemo: ObservableObject, RenderableGraphContainer, Demo {

    static var initialGraphColor = SIMD4<Float>(0.2, 0.2, 0.2, 1)

    var graph: AppearanceDemoGraph

    var renderController: RenderController

    var povController: POVController

    var wireframeSettings: GraphWireframeSettings

    var type: DemoType { return .appearance }

    var info: String { return "Previews configuration settings affecting the graph's appearance." }
    init() {
        self.graph = AppearanceDemoGraph()
        self.renderController = RenderController()
        self.povController = POVController(pov: POV(location: SIMD3<Float>(2, 0, 3)))
        self.wireframeSettings = GraphWireframeSettings(nodeColorDefault: Self.initialGraphColor,
                                                        edgeColor: Self.initialGraphColor)

        GraphBuilder(nodeValueFactory: AppearanceDemoNodeValue.init,
                    edgeValueFactory: AppearanceDemoEdgeValue.init)
            .addCube(to: graph)
    }

    func updateGraph() {
        fireGraphChange(RenderableGraphChange(nodeColors: true))
    }
}
