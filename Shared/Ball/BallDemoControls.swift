//
//  BallDemoView.swift
//  GraphMetal-Demo
//
//  Created by Jim Hanson on 11/29/21.
//

import SwiftUI
import GraphMetal

struct BallDemoControls: View {

    @ObservedObject var demo: BallDemo

    var body: some View {
        VStack(alignment: .center, spacing: 20) {


            HStack(spacing: 30) {
                Button {
                    demo.growing = true
                } label: {
                    Image(systemName: "play.fill")
                }
                .buttonStyle(.bordered)
                .imageScale(.large)
                .help("Start")

                Button {
                    demo.growing = false
                } label: {
                    Image(systemName: "pause.fill")
                }
                .buttonStyle(.bordered)
                .imageScale(.large)
                .help("Stop")

                Button {
                    demo.reset()
                } label: {
                    Image(systemName: "arrow.counterclockwise")
                }
                .buttonStyle(.bordered)
                .imageScale(.large)
                .help("Reset")
            }
            .frame(maxWidth: .infinity)

            HStack {
                VStack(alignment: .leading, spacing: 10) {
                    HStack(spacing: 5) {
                        Text("# nodes:")
                        Text("\(demo.nodeCount)")
                    }

                    HStack(spacing: 5) {
                        Text("# edges:")
                        Text("\(demo.edgeCount)")
                    }
                }
                .frame(maxWidth: .infinity)
            }
        }
    }
}

