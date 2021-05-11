//
//  BallSettingsView.swift
//  GraphMetal-Demo
//
//  Created by Jim Hanson on 5/10/21.
//

import SwiftUI
import UIStuffForSwift

struct BallSettingsView : View {

    @ObservedObject var demo: BallDemo

    @State var group = SettingsGroup().itemStyle(.narrow)

    var body: some View {
        VStack(alignment: .center) {

            Text("#nodes: \(demo.nodeCount)")

            Text("#edges: \(demo.edgeCount)")

            Button(action: { demo.growing = true }) {
                Text("Start")
            }
            .foregroundColor(UIConstants.controlColor)
            .modifier(SymbolButtonStyle())

            Button(action: { demo.growing = false }) {
                Text("Stop")
            }
            .foregroundColor(UIConstants.controlColor)
            .modifier(SymbolButtonStyle())

        }.frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    init(_ demo: BallDemo) {
        self.demo = demo
    }
}
