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

    var info: String { return "Previews configuration settings affecting the graph's appearance" }
    init() {
        self.graph = GraphBuilder(AppearanceDemoNodeValue.init, AppearanceDemoEdgeValue.init)
            .simpleCube()
        self.renderController = RenderController()
        self.povController = POVController(pov: POV(location: SIMD3<Float>(4, 0, 6)))
        self.wireframeSettings = GraphWireframeSettings(nodeColorDefault: Self.initialGraphColor,
                                                        edgeColor: Self.initialGraphColor)
    }

    func updateGraph() {
        fireGraphChange(RenderableGraphChange(nodeColors: true))
    }
}
