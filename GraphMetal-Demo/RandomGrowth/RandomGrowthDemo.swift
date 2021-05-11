//
//  RandomGrowthDemo.swift
//  GraphMetal-Demo
//
//  Created by Jim Hanson on 5/10/21.
//

import SwiftUI
import GenericGraph
import GraphMetal


struct RandomGrowthNodeValue: RenderableNodeValue {

    let colorFadeTime: TimeInterval = 5

    func green(_ f: Float) -> Float {
        return 1.25 - f
    }

    func red(_ f: Float) -> Float {
        return 0
    }

    func blue(_ f: Float) -> Float {
        return 0
    }

    func alpha(_ f: Float) -> Float {
        return 1 // (f < 2) ? 1 : 3 - f
    }

    var hidden: Bool { return false }

    var color: SIMD4<Float>? {
        let f: Float = Float(Date().timeIntervalSince(creationTime) / colorFadeTime)
        return SIMD4<Float>(red(f).clamp(0, 1),
                            green(f).clamp(0, 1),
                            blue(f).clamp(0, 1),
                            alpha(f).clamp(0, 1))
    }

    var location: SIMD3<Float>

    let creationTime: Date

    init(_ location: SIMD3<Float>) {
        self.location = location
        self.creationTime = Date()
    }
}

struct RandomGrowthEdgeValue: RenderableEdgeValue {

    var hidden: Bool { return false }
}

typealias RandomGrowthGraph = BaseGraph<RandomGrowthNodeValue, RandomGrowthEdgeValue>

typealias RandomGrowthController = BasicGraphController<RandomGrowthGraph>

class RandomGrowthDemo : ObservableObject, Demo {

    var type: DemoType = .randomGrowth

    var name: String = DemoType.randomGrowth.rawValue

    var graphController: RandomGrowthController? = nil

    var povController: POVController? = nil

    var settingsView: some View {
        RandomGrowthSettingsView(self)
    }

    var displayView: some View {
        RandomGrowthDisplayView(self)
    }

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

    private var lastStepTimestamp: Date = .distantPast

    @Published var newNodeTimeInterval: Double = 0.5

    @Published var newNodeOutDegree: Int = 2

    private var _lastNewNodeTimestamp: Date = .distantPast

    private var stopIsRequested: Bool = false

    private var stepIsScheduled: Bool = false

    func setup() {
        self.graphController = RandomGrowthController(
            BaseGraph<RandomGrowthNodeValue, RandomGrowthEdgeValue>(),
            DispatchQueue(label: "RandomGrowthDemo", qos: .userInitiated))
        self.povController = POVController()
    }

    func teardown() {
        self.graphController = nil
        self.povController = nil
    }

    func possiblyScheduleNextStep() {
        if !(self.stopIsRequested || self.stepIsScheduled) {
            self.stepIsScheduled = true
            let stepDelay =  stepTimeInterval - Date().timeIntervalSince(lastStepTimestamp)
            if (stepDelay > 0) {
                graphController?.schedule(step, stepDelay, self.stepCompleted)
            }
            else {
                graphController?.exec(step, self.stepCompleted)
            }
        }
    }

    func step(_ graphHolder: BasicGraphHolder<RandomGrowthGraph>) -> StepResult {
        let now = Date()
        var nodeAdded = false
        if now.timeIntervalSince(_lastNewNodeTimestamp) >= newNodeTimeInterval {
            addNode(graphHolder.graph)
            graphHolder.registerTopologyChange()
            _lastNewNodeTimestamp = now
            nodeAdded = true
        }
        else {
            graphHolder.registerColorChange()
        }
        return StepResult(nodeAdded: nodeAdded)
    }

    func addNode(_ graph: RandomGrowthGraph) {
        let outDegree = min(graph.nodes.count, self.newNodeOutDegree)
        var targetIDs = [NodeID]()
        for node in graph.nodes.shuffled().prefix(outDegree) {
            targetIDs.append(node.id)
        }

        let newNode = graph.addNode(RandomGrowthNodeValue(randomLocation()))
        for targetID in targetIDs {
            try!graph.addEdge(newNode.id, targetID, RandomGrowthEdgeValue())
        }
    }

    func stepCompleted(_ result: StepResult) {
        self.stepIsScheduled = false
        self.lastStepTimestamp = Date()
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
}
