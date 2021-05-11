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

    let colorFadeTime: Float = 10

    var red: Float {
        return 1 - (Float(demo._currentStep - creationTime) / colorFadeTime).clamp(0, 1)
    }

    let green: Float = 0

    let blue: Float = 0

    let alpha: Float = 1

    var hidden: Bool { return false }

    var color: SIMD4<Float>? {
        return SIMD4<Float>(red, green, blue, alpha)
    }

    weak var demo: RandomGrowthDemo!

    var location: SIMD3<Float>

    let creationTime: Int

    init(_ demo: RandomGrowthDemo, _ location: SIMD3<Float>, _ creationTime: Int) {
        self.demo = demo
        self.location = location
        self.creationTime = creationTime
    }
}

struct RandomGrowthEdgeValue: RenderableEdgeValue {

    var hidden: Bool { return false }

}

typealias RandomGrowthGraph = BaseGraph<RandomGrowthNodeValue, RandomGrowthEdgeValue>

typealias RandomGrowthController = BasicGraphController<RandomGrowthGraph>

//struct RandomGrowthController : RenderableGraphController {
//
//    public typealias HolderType = BasicGraphHolder<RandomGrowthGraph>
//
//    public var graphHolder: BasicGraphHolder<RandomGrowthGraph>
//
//    public var dispatchQueue: DispatchQueue
//
//    var stopRequested: Bool = false
//
//    public init(_ graph: RandomGrowthGraph, _ dispatchQueue: DispatchQueue) {
//        self.graphHolder = BasicGraphHolder(graph)
//        self.dispatchQueue = dispatchQueue
//    }
//
//    func start() {
//
//    }
//
//    func stop() {
//
//    }
//}

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

    @Published var newNodeInterval: Double = 1

    @Published var newNodeOutDegree: Int = 2

    private var stopIsRequested: Bool = false

    private var stepIsScheduled: Bool = false

    private var lastStepTimestamp: Date = .distantPast

    // background thread only
    var _currentStep: Int = 0

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
            let updateDelay =  newNodeInterval - Date().timeIntervalSince(lastStepTimestamp)
            if (updateDelay > 0) {
                graphController?.schedule(step, updateDelay, self.stepCompleted)
            }
            else {
                graphController?.exec(step, self.stepCompleted)
            }
        }
    }

    func step(_ graphHolder: BasicGraphHolder<RandomGrowthGraph>) {

        let outDegree = min(graphHolder.graph.nodes.count, self.newNodeOutDegree)
        var targetIDs = [NodeID]()
        for node in graphHolder.graph.nodes.shuffled().prefix(outDegree) {
            targetIDs.append(node.id)
        }

        let newNode = graphHolder.graph.addNode(RandomGrowthNodeValue(self, randomLocation(), self._currentStep))
        for targetID in targetIDs {
            try! graphHolder.graph.addEdge(newNode.id, targetID, RandomGrowthEdgeValue())
        }

        graphHolder.registerTopologyChange()
        self._currentStep += 1
    }

    func stepCompleted() {
        self.stepIsScheduled = false
        self.lastStepTimestamp = Date()
        possiblyScheduleNextStep()
    }

    func randomLocation() -> SIMD3<Float> {
        return SIMD3<Float>(x: Float.random(in: -1...1),
                            y: Float.random(in: -1...1),
                            z: Float.random(in: -1...1))
    }
}
