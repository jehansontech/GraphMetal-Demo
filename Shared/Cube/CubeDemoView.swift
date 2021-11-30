//
//  CubeDemoView.swift
//  GraphMetal-Demo
//
//  Created by Jim Hanson on 11/29/21.
//

import SwiftUI
import GraphMetal

struct CubeDemoView: View {

    @ObservedObject var demo: CubeDemo
    
    var body: some View {
        NavigationView {
            CubeSettingsView(demo)
            GraphView($demo.rendererSettings,
                      demo,
                      demo.povController)
        }
        .onAppear {
            demo.setup()
        }
        .onDisappear {
            demo.teardown()
        }
    }

    init(_ demo: CubeDemo) {
        self.demo = demo
    }
}

struct CubeSettingsView: View {

    @ObservedObject var demo: CubeDemo

    @State private var background: Double = 0
    @State private var edges: Double = 0
    // @State private var green: Double = 0
    // @State private var blue: Double = 0

    // @State var group = SettingsGroup().itemStyle(.narrow)

    var body: some View {
        VStack {
            Text("Nodes")
                .frame(maxWidth: .infinity, alignment: .leading)

            //            RangeSetting("Size", $demo.rendererSettings.nodeSize, $group, 1, 500, 1)
            //
            //            RangeSetting("Red", $demo.red, $group, 0, 1, 0.01)
            //
            //            RangeSetting("Green", $demo.green, $group, 0, 1, 0.01)
            //
            //            RangeSetting("Blue", $demo.blue, $group, 0, 1, 0.01)

            //            Divider().background(UIConstants.darkGray)

            //            RangeSetting("Edges", $edges, $group, 0, 1, 0.01)
            //                .onChange(of: edges) { value in
            //                    demo.rendererSettings.edgeColorDefault = SIMD4<Double>(value, value, value, 1)
            //                }
            //
            //            RangeSetting("Background", $background, $group, 0, 1, 0.01)
            //                .onChange(of: background) { value in
            //                    demo.rendererSettings.backgroundColor = SIMD4<Double>(value, value, value, 1)
            //                }


        }
    }

    init(_ cube: CubeDemo) {
        self.demo = cube
    }
}
