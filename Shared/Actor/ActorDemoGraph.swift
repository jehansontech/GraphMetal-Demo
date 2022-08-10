//
//  ActorDemoGraph.swift
//  GraphMetal-Demo
//
//  Created by Jim Hanson on 7/26/22.
//

import GenericGraph
import GraphMetal

struct ActorDemoNodeValue: RenderableNodeValue {
    var color: SIMD4<Float>?

    var location: SIMD3<Float>


}

struct ActorDemoEdgeValue: RenderableEdgeValue {
    var hidden: Bool

    
}

typealias ActorDemoNode  = BaseGraphNode<ActorDemoNodeValue, ActorDemoEdgeValue>
typealias ActorDemoEdge  = BaseGraphEdge<ActorDemoNodeValue, ActorDemoEdgeValue>
typealias ActorDemoGraph = BaseGraph<ActorDemoNodeValue, ActorDemoEdgeValue>

class ActorDemoGraphContainer: RenderableGraphContainer {

    // I get a compiler error if I try to make this an actor:
    // "Actor-isolated property cannot be used to satisfy a protocol requirement"

    var graph: ActorDemoGraph

    init() {
        graph = ActorDemoGraph()
    }
}

actor ActorDemoGraphIsolator {
    var graphContainer: ActorDemoGraphContainer

    init() {
        graphContainer = ActorDemoGraphContainer()
    }
}
