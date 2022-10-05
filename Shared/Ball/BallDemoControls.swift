//
//  BallDemoControls.swift
//  GraphMetal-Demo
//
//  Created by Jim Hanson on 11/29/21.
//

import SwiftUI
import GraphMetal

struct BallDemoControls: View {

    @ObservedObject var viewModel: BallDemoViewModel

    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            HStack(spacing: 30) {
                Button {
                    viewModel.start()
                } label: {
                    Image(systemName: "play.fill")
                }
                .buttonStyle(.bordered)
                .imageScale(.large)
                .help("Start")

                Button {
                    viewModel.stop()
                } label: {
                    Image(systemName: "stop.fill")
                }
                .buttonStyle(.bordered)
                .imageScale(.large)
                .help("Stop")

                Button {
                    viewModel.reset()
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
                        Text("\(viewModel.nodeCount)")
                    }

                    HStack(spacing: 5) {
                        Text("# edges:")
                        Text("\(viewModel.edgeCount)")
                    }
                }
                .frame(maxWidth: .infinity)
            }
        }
    }

    init(_ viewModel: BallDemoViewModel) {
        self.viewModel = viewModel
    }
}

