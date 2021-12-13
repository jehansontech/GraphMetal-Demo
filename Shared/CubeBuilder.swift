//
//  CubeBuilder.swift
//  GraphMetal-Demo
//
//  Created by Jim Hanson on 12/13/21.
//

import Foundation
import GenericGraph
import GraphMetal

struct CubeBuilder<N, E> where N: RenderableNodeValue, E: RenderableEdgeValue {

    typealias NodeValueFactory = (SIMD3<Float>) -> N?
    typealias EdgeValueFactory = () -> E?

    var center: SIMD3<Float> = .zero

    var divisions: Int = 0

    var nodeValueFactory: NodeValueFactory? = nil

    var edgeValueFactory: EdgeValueFactory? = nil

    func addCube(to graph: BaseGraph<N, E>) {
        var edges = startCube(graph)
        for _ in 0..<divisions {
            edges = divideEdges(graph, edges)
        }
    }

    private func startCube(_ graph: BaseGraph<N, E>) -> [EdgeID] {
        var newEdges = [EdgeID]()

        let a: Float = pow(2, Float(divisions-1))

        let n0 = makeNode(graph, SIMD3<Float>(-a, -a, -a))
        let n1 = makeNode(graph, SIMD3<Float>(-a, -a,  a))
        let n2 = makeNode(graph, SIMD3<Float>(-a,  a,  a))
        let n3 = makeNode(graph, SIMD3<Float>(-a,  a, -a))
        let n4 = makeNode(graph, SIMD3<Float>( a, -a, -a))
        let n5 = makeNode(graph, SIMD3<Float>( a, -a,  a))
        let n6 = makeNode(graph, SIMD3<Float>( a,  a,  a))
        let n7 = makeNode(graph, SIMD3<Float>( a,  a, -a))

        newEdges.append(makeEdge(graph, n0, n1))
        newEdges.append(makeEdge(graph, n1, n2))
        newEdges.append(makeEdge(graph, n2, n3))
        newEdges.append(makeEdge(graph, n3, n0))
        newEdges.append(makeEdge(graph, n4, n5))
        newEdges.append(makeEdge(graph, n5, n6))
        newEdges.append(makeEdge(graph, n6, n7))
        newEdges.append(makeEdge(graph, n7, n4))
        newEdges.append(makeEdge(graph, n0, n4))
        newEdges.append(makeEdge(graph, n1, n5))
        newEdges.append(makeEdge(graph, n2, n6))
        newEdges.append(makeEdge(graph, n3, n7))

        return newEdges
    }

    private func makeNode(_ graph: BaseGraph<N, E>, _ location: SIMD3<Float>) -> NodeID {
        var newValue: N? = nil
        if let factory = nodeValueFactory {
            newValue = factory(location)
        }
        let newNode = graph.addNode(newValue)
        return newNode.id
    }

    private func makeEdge(_ graph: BaseGraph<N, E>, _ source: NodeID, _ target: NodeID) -> EdgeID {
        var newValue: E? = nil
        if let factory = edgeValueFactory {
            newValue = factory()
        }
        let newEdge = try! graph.addEdge(source, target, newValue)
        return newEdge.id
    }

    private func divideEdges(_ graph: BaseGraph<N, E>, _ oldEdges: [EdgeID]) -> [EdgeID] {
        var newEdges = [EdgeID]()
        for edgeID in oldEdges {
            if let edge = graph.edges[edgeID] {
                let source = edge.source
                let target = edge.target
                let midpoint = 0.5 * (source.value!.location + target.value!.location)
                let newNodeID = makeNode(graph, midpoint)
                newEdges.append(makeEdge(graph, source.id, newNodeID))
                newEdges.append(makeEdge(graph, newNodeID, target.id))
            }
            graph.removeEdge(edgeID)
        }
        return newEdges
    }
}
