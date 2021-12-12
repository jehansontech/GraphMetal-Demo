//
//  CubeDemoView.swift
//  GraphMetal-Demo
//
//  Created by Jim Hanson on 11/29/21.
//

import SwiftUI
import Wacoma
import GraphMetal

struct CubeSettingsView: View {

    @ObservedObject var demo: CubeDemo

    var body: some View {
        VStack(alignment: .leading) {

            DisclosureGroup("Node size") {
                Slider(value: $demo.wireframeSettings.nodeSize, in: 1...200)
                    .settingControl()
            }

            DisclosureGroup("Nodegroup colors") {
                VStack {
                    HStack {
                        Text("R")
                        Slider(value: $demo.red, in: 0...1)
                    }
                    HStack {
                        Text("G")
                        Slider(value: $demo.green, in: 0...1)
                    }
                    HStack {
                        Text("B")
                        Slider(value: $demo.blue, in: 0...1)
                    }
                }
                .settingControl()
            }

            // ColorPicker("Edge color", selection: $demo.wireframeSettings.edgeColor)

            DisclosureGroup("Orbit") {
                VStack {
                    Toggle("Enabled", isOn: $demo.povController.orbitEnabled)
                    Slider(value: $demo.povController.orbitSpeed, in: -1...1)
                        .settingControl()
                }
            }

            Spacer()
        }
    }

    init(_ cube: CubeDemo) {
        self.demo = cube
    }
}

struct CubeDisplayView: View {

    @ObservedObject var cube: CubeDemo

    var body: some View {
        GraphView(cube,
                  renderController: cube.renderController,
                  povController: cube.povController,
                  wireframeSettings: cube.wireframeSettings)
            .onAppear {
                cube.setup()
            }
            .onDisappear {
                cube.teardown()
            }
    }

    init(_ cube: CubeDemo) {
        self.cube = cube
    }
}
