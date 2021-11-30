//
//  BallDemo.swift
//  GraphMetal-Demo
//
//  Created by Jim Hanson on 5/10/21.
//

import SwiftUI
import GenericGraph
import GraphMetal
import Wacoma

class BallDemo: ObservableObject, RenderableGraphHolder {

    var dispatchQueue: DispatchQueue

    var graph: BallGraph

    var povController: POVController

    @Published var rendererSettings = RendererSettings(nodeSizeAutomatic: false)

    @Published var growing: Bool = true {
        didSet {
            print("growing = \(growing)")
            if growing {
                stopIsRequested = false
                possiblyScheduleNextStep()
            }
            else {
                stopIsRequested = true
            }
        }
    }

    @Published var stepTimeInterval: Double = 1/30

    @Published var nodeCount: Int = 0

    @Published var edgeCount: Int = 0

    private var lastStepTimestamp: Date = .distantPast

    @Published var newNodeTimeInterval: Double = 0.5

    @Published var newNodeOutDegree: Int = 2

    private var _lastNewNodeTimestamp: Date = .distantPast

    private var stopIsRequested: Bool = false

    private var stepIsScheduled: Bool = false

    init() {
        self.graph = BallGraph()
        self.povController = POVController()
        self.dispatchQueue = DispatchQueue(label: "BallDemo", qos: .userInitiated)
    }

    func setup() {
        //        self.graphController = BallController(
        //            BaseGraph<BallNodeValue, BallEdgeValue>(),
        //            DispatchQueue(label: "BallDemo", qos: .userInitiated))
        //self.povController = POVController()
    }

    func teardown() {
        // TODO graph
        // TODO queue
        // self.graphController = nil
            // self.povController = nil
    }

    func possiblyScheduleNextStep() {
        if !(self.stopIsRequested || self.stepIsScheduled) {
            self.stepIsScheduled = true
            let stepDelay =  stepTimeInterval - Date().timeIntervalSince(lastStepTimestamp)
            if (stepDelay > 0) {
                dispatchQueue.asyncAfter(deadline: .now() + stepDelay) { [self] in
                    let result = step()
                    DispatchQueue.main.sync {
                        stepCompleted(result)
                    }
                }
            }
            else {
                dispatchQueue.async { [self] in
                    let result = step()
                    DispatchQueue.main.sync {
                        stepCompleted(result)
                    }
                }
            }
        }
    }

    func step() -> StepResult {
        debug("BallDemo", "step: started")
        let now = Date()
        var nodeAdded = false
        if now.timeIntervalSince(_lastNewNodeTimestamp) >= newNodeTimeInterval {
            addNode(graph)
            _lastNewNodeTimestamp = now
            nodeAdded = true
            fireGraphChange(RenderableGraphChange.ALL)
        }
        else {
            fireGraphChange(RenderableGraphChange(nodeColors: true))
        }
        debug("BallDemo", "step: done")
        return StepResult(nodeAdded: nodeAdded,
                          nodeCount: graph.nodes.count,
                          edgeCount: graph.edges.count)
    }

    func addNode(_ graph: BallGraph) {
        let outDegree = min(graph.nodes.count, self.newNodeOutDegree)
        var targetIDs = [NodeID]()
        for node in graph.nodes.shuffled().prefix(outDegree) {
            targetIDs.append(node.id)
        }

        let newNode = graph.addNode(BallNodeValue(randomLocation()))
        for targetID in targetIDs {
            try!graph.addEdge(newNode.id, targetID, BallEdgeValue())
        }
    }

    func stepCompleted(_ result: StepResult) {
        self.stepIsScheduled = false
        self.lastStepTimestamp = Date()
        self.nodeCount = result.nodeCount
        self.edgeCount = result.edgeCount
        possiblyScheduleNextStep()
    }

    func randomLocation() -> SIMD3<Float> {
        let r: Float = 1
        let theta: Float = Float.random(in: 0..<Float.pi)
        let phi: Float = Float.random(in: 0..<Float.twoPi)
        return sphericalToCartesian(rtp: SIMD3<Float>(r, theta, phi))
    }
}

struct StepResult {
    var nodeAdded: Bool
    var nodeCount: Int
    var edgeCount: Int
}

struct BallNodeValue: RenderableNodeValue {

    let colorFadeTime: TimeInterval = 5

    var hidden: Bool { return false }

    var color: SIMD4<Float>? {
        let f: Float = Float(Date().timeIntervalSince(creationTime) / colorFadeTime)
        return SIMD4<Float>(0,
                            (1 - f).clamp(0, 1),
                            0,
                            1)
    }

    var location: SIMD3<Float>

    let creationTime: Date

    init(_ location: SIMD3<Float>) {
        self.location = location
        self.creationTime = Date()
    }
}

struct BallEdgeValue: RenderableEdgeValue {

    var hidden: Bool { return false }
}

typealias BallGraph = BaseGraph<BallNodeValue, BallEdgeValue>


