//
//  BallDemoView.swift
//  GraphMetal-Demo
//
//  Created by Jim Hanson on 11/29/21.
//

import SwiftUI
import GraphMetal

struct BallSettingsView: View {

    @ObservedObject var ball: BallDemo

    var nodeCount: Int {
        return ball.graph.nodes.count
    }

    var edgeCount: Int {
        return ball.graph.edges.count
    }

    var body: some View {
        VStack(alignment: .center, spacing: 20) {

            VStack(alignment: .leading, spacing: 10) {
                HStack(spacing: 5) {
                    Text("# nodes:")
                    Text("\(nodeCount)")
                    Spacer()
                }

                HStack(spacing: 5) {
                    Text("# edges:")
                    Text("\(edgeCount)")
                    Spacer()
                }
            }
            .frame(maxWidth: .infinity)

            HStack(spacing: 25) {
                Button {
                    ball.growing = true
                } label: {
                    Image(systemName: "play.fill")
                }
                .help("Start")

                Button {
                    ball.growing = false
                } label: {
                    Image(systemName: "pause.fill")
                }
                .help("Stop")

                Button {
                    ball.reset()
                } label: {
                    Image(systemName: "arrow.counterclockwise")
                }
                .help("Reset")
            }
            .frame(maxWidth: .infinity)

            Spacer()
        }
    }

    init(_ ball: BallDemo) {
        self.ball = ball
    }
}

struct BallDisplayView: View {

    @ObservedObject var ball: BallDemo

    var body: some View {
        GraphView($ball.rendererSettings,
                  ball,
                  ball.povController)
            .onAppear {
                ball.setup()
            }
            .onDisappear {
                ball.teardown()
            }
    }

    init(_ ball: BallDemo) {
        self.ball = ball
    }
}
