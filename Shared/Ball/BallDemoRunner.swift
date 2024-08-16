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

    private var generator: ZWireframeWithColoredNodes.UpdateGenerator

    private var lastNewNodeTimestamp: Date = .distantPast

    private var lastStepCompletionDate: Date = .distantPast

    init() {
        self.graph = BallDemoGraph()
        self.settings = BallDemoSettings()
        self.generator = ZWireframeWithColoredNodes.UpdateGenerator()
    }

    func connect(_ demo: BallDemoViewModel) async {
        self.demo = demo
        let stepResult = makeStepResult()
        Task {
            await self.demo.applyStepResult(stepResult)
        }
    }

    func start() async {
        if !isRunning {
            isRunning = true
            await self.demo.applyStepResult(makeStepResult())
            lastStepCompletionDate = Date()
            while isRunning {
                do {
                    try await step()
                } catch {
                    print("\(error)")
                    isRunning = false
                }
            }
            await self.demo.applyStepResult(makeStepResult())
            lastStepCompletionDate = Date()
        }
    }

    func stop() async {
        let shouldSendUpdate = !isRunning

        isRunning = false

        if shouldSendUpdate {
            let stepResult = makeStepResult()
            Task.detached {
                await self.demo.applyStepResult(stepResult)
            }
        }
    }

    func reset() async {
        let shouldSendUpdate = !isRunning

        self.graph = BallDemoGraph()
        if shouldSendUpdate {
            let update = makeStepResult()
            Task {
                await self.demo.applyStepResult(update)
            }
        }
    }

    func step() async throws {
        let t0 = Date()
        await self.demo.applyStepResult(doStep())
        let sleepTime = settings.stepTimeInterval - Date().timeIntervalSince(t0)
        if sleepTime > 0 {
            await Task.uncheckedSleep(seconds: sleepTime)
        }
    }

    private func doStep() -> StepResult {
        if Date().timeIntervalSince(lastNewNodeTimestamp) >= settings.newNodeTimeInterval {
            addNode(graph)
            generator.graphHasChanged(graph, nodeSet: true)
            lastNewNodeTimestamp = Date()
        }
        else {
            generator.graphHasChanged(graph, nodeColors: true)
        }
        return makeStepResult()
    }

    private func makeStepResult() -> StepResult {
        return StepResult(isRunning: self.isRunning,
                          nodeCount: graph.nodes.count,
                          edgeCount: graph.edges.count,
                          wireframeUpdate: generator.makeUpdate(graph))
    }

    private func addNode(_ graph: BallDemoGraph) {
        let outDegree = min(graph.nodes.count, settings.newNodeOutDegree)
        var targetIDs = [Int]()
        for node in graph.nodes.shuffled().prefix(outDegree) {
            targetIDs.append(node.nodeNumber)
        }

        let newNode = graph.addNode(BallDemoNodeValue(randomLocation()))
        for targetID in targetIDs {
            try! graph.addEdge(newNode.nodeNumber, targetID)
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
    var wireframeUpdate: ZWireframeWithColoredNodes.Update?
}

