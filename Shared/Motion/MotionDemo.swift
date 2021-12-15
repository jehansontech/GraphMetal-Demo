//
//  MotionDemo.swift
//  GraphMetal-Demo (iOS)
//
//  Created by Jim Hanson on 12/14/21.
//

import SwiftUI
import GenericGraph
import GraphMetal

class MotionDemo: ObservableObject, RenderableGraphContainer, Demo {

    static var graphColor = SIMD4<Float>(0.5,1,0,1)

    var graph: MotionDemoGraph

    var type: DemoType { return .motion }

    var info: String { return "How to move around . . ." }

    init() {
        self.graph = MotionDemoGraph()
        GraphBuilder(divisions: 0, nodeValueFactory: MotionDemoNodeValue.init,
                    edgeValueFactory: MotionDemoEdgeValue.init)
            .addCube(to: graph)
    }
}

