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

class BallDemo: ObservableObject, RenderableGraphContainer, Demo {

    var dispatchQueue: DispatchQueue

    var graph: BallDemoGraph

    var renderController: RenderController

    var povController = OrbitingPOVController(pov: CenteredPOV(location: SIMD3<Float>(0, 0, -2)), orbitEnabled: false)

    var fovController = PerspectiveFOVController()

    var type: DemoType { return .ball }

    var info: String { return "Shows a graph that changes over time" }

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
        self.dispatchQueue = DispatchQueue(label: "BallDemo", qos: .userInitiated)
        self.graph = BallDemoGraph()
        self.renderController = RenderController(povController, PerspectiveFOVController())
        self.renderController.renderables.append(Wireframe(self))
    }

    func reset() {
        self.graph = BallDemoGraph()
        fireGraphChange(.all)
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
            fireGraphChange(RenderableGraphChange.all)
        }
        else {
            fireGraphChange(RenderableGraphChange(nodeColors: true))
        }
        debug("BallDemo", "step: done")
        return StepResult(nodeAdded: nodeAdded,
                          nodeCount: graph.nodes.count,
                          edgeCount: graph.edges.count)
    }

    func addNode(_ graph: BallDemoGraph) {
        let outDegree = min(graph.nodes.count, self.newNodeOutDegree)
        var targetIDs = [NodeID]()
        for node in graph.nodes.shuffled().prefix(outDegree) {
            targetIDs.append(node.id)
        }

        let newNode = graph.addNode(BallDemoNodeValue(randomLocation()))
        for targetID in targetIDs {
            try!graph.addEdge(newNode.id, targetID, BallDemoEdgeValue())
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

