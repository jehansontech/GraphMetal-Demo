//
//  CubeSettingsView.swift
//  GraphMetal-Demo
//
//  Created by Jim Hanson on 4/27/21.
//

import SwiftUI
import Taconic
import UIStuffForSwift

struct CubeSettingsView: View {

    @ObservedObject var cube: CubeDemo

    @State private var background: Double = 0
    @State private var edges: Double = 0
    @State private var green: Double = 0
    @State private var blue: Double = 0

    @State var group = SettingsGroup().itemStyle(.narrow)

    var body: some View {
        VStack {
            Text("Nodes")
                .frame(maxWidth: .infinity, alignment: .leading)

            RangeSetting("Size", $cube.renderSettings.nodeSize, $group, 1, 500, 1)

            RangeSetting("Red", $cube.red, $group, 0, 1, 0.01)

            RangeSetting("Green", $cube.green, $group, 0, 1, 0.01)

            RangeSetting("Blue", $cube.blue, $group, 0, 1, 0.01)

            Divider().background(UIConstants.darkGray)

            RangeSetting("Edges", $edges, $group, 0, 1, 0.01)
                .onChange(of: edges) { value in
                    cube.renderSettings.edgeColor = SIMD4<Double>(value, value, value, 1)
                }

            RangeSetting("Background", $background, $group, 0, 1, 0.01)
                .onChange(of: background) { value in
                    cube.renderSettings.backgroundColor = SIMD4<Double>(value, value, value, 1)
                }


        }
    }

    init(_ cube: CubeDemo) {
        self.cube = cube
    }
}
