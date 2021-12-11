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

    @State private var edges: Double = 0

    @State private var background: Double = 0

    var body: some View {
        VStack(alignment: .leading) {

            DisclosureGroup("Node size") {
                Slider(value: $demo.wireframeSettings.nodeSize, in: 1...200)
                    .settingControl()
            }

            DisclosureGroup("Node colors") {
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

//            DisclosureGroup("Edges") {
//                Slider(value: $edges, in: 0...1)
//                    .onChange(of: edges) { value in
//                            demo.wireframeSettings.edgeColor = SIMD4<Double>(value, value, value, 1)
//                    }
//                    .settingControl()
//            }
//
//            DisclosureGroup("Background") {
//                Slider(value: $background, in: 0...1)
//                    .onChange(of: background) { value in
//                        let newBG = SIMD4<Double>(value, value, value, 1)
//                        debug("CubeSettingsView", "setting background to \(newBG.prettyString)")
//                        demo.graphRendererSettings.backgroundColor = newBG
//                    }
//                    .settingControl()
//            }

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
                  povController: cube.povController,
                  rendererSettings: cube.graphRendererSettings,
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