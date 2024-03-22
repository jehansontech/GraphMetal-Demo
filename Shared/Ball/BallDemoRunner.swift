//
//  BallDemoRunner.swift
//  GraphMetal-Demo
//
//  Created by Jim Hanson on 10/5/22.
//

import Foundation
import Wacoma
import GenericGraph
import GraphMetal

struct BallDemoSettings {

    var stepTimeInterval: TimeInterval = 1/30

    var newNodeTimeInterval: Double = 0.25

    var newNodeOutDegree: Int = 2

}

actor BallDemoRunner {

    var demo: BallDemoViewModel!

    var settings: BallDemoSettings

    var isRunning: Bool = false

    var graph: BallDemoGraph

    private var generator: WireframeUpdateGenerator = .init()

    private var lastNewNodeTimestamp: Date = .distantPast

    private var lastStepCompletionDate: Date = .distantPast

    init() {
        self.graph = BallDemoGraph()
        self.settings = BallDemoSettings()
    }

    func connect(_ demo: BallDemoViewModel) async {
        self.demo = demo
        let update = makeStatusUpdate()
        Task {
            await self.demo.applyUpdate(update)
        }
    }

    func start() async {
        if !isRunning {
            isRunning = true
            await self.demo.applyUpdate(makeStatusUpdate())
            lastStepCompletionDate = Date()
            while isRunning {
                do {
                    try await step()
                } catch {
                    print("\(error)")
                    isRunning = false
                }
            }
            await self.demo.applyUpdate(makeStatusUpdate())
            lastStepCompletionDate = Date()
        }
    }

    func stop() async {
        let shouldSendUpdate = !isRunning

        isRunning = false

        if shouldSendUpdate {
            let update = makeStatusUpdate()
            Task.detached {
                await self.demo.applyUpdate(update)
            }
        }
    }

    func reset() async {
        let shouldSendUpdate = !isRunning

        graph = BallDemoGraph()

        if shouldSendUpdate {
            let update = makeTotalUpdate()
            Task {
                await self.demo.applyUpdate(update)
            }
        }
    }

    func step() async throws {
        let t0 = Date()
        await self.demo.applyUpdate(doStep())
        let sleepTime = settings.stepTimeInterval - Date().timeIntervalSince(t0)
        if sleepTime > 0 {
            await Task.uncheckedSleep(seconds: sleepTime)
        }
    }

    private func doStep() -> StepResult {
        var nodeAdded = false
        if Date().timeIntervalSince(lastNewNodeTimestamp) >= settings.newNodeTimeInterval {
            addNode(graph)
            lastNewNodeTimestamp = Date()
            nodeAdded = true
        }
        return makeStepUpdate(nodeAdded)
    }

    private func makeStatusUpdate() -> StepResult {
        return StepResult(isRunning: self.isRunning,
                          nodeCount: graph.nodes.count,
                          edgeCount: graph.edges.count,
                          wireframeUpdate: nil)
    }

    private func makeStepUpdate(_ nodeAdded: Bool) -> StepResult {
        return StepResult(isRunning: self.isRunning,
                          nodeCount: graph.nodes.count,
                          edgeCount: graph.edges.count,
                          wireframeUpdate: generator.makeUpdate(graph,
                                                                nodeAdded ? .topology : .nodeColors))
    }

    private func makeTotalUpdate() -> StepResult {
        return StepResult(isRunning: self.isRunning,
                          nodeCount: graph.nodes.count,
                          edgeCount: graph.edges.count,
                          wireframeUpdate: generator.makeUpdate(graph, .all))
    }

    private func addNode(_ graph: BallDemoGraph) {
        let outDegree = min(graph.nodes.count, settings.newNodeOutDegree)
        var targetIDs = [Int]()
        for node in graph.nodes.shuffled().prefix(outDegree) {
            targetIDs.append(node.nodeNumber)
        }

        let newNode = graph.addNode(BallDemoNodeValue(randomLocation()))
        for targetID in targetIDs {
            try! graph.addEdge(newNode.nodeNumber, targetID, BallDemoEdgeValue())
        }
    }

    private func randomLocation() -> SIMD3<Float> {
        let r: Float = 1
        let theta: Float = Float.random(in: 0..<Float.pi)
        let phi: Float = Float.random(in: 0..<Float.twoPi)
        return sphericalToCartesian(rtp: SIMD3<Float>(r, theta, phi))
    }
}

struct StepResult: Sendable {
    var isRunning: Bool
    var nodeCount: Int
    var edgeCount: Int
    var wireframeUpdate: WireframeUpdate?
}

