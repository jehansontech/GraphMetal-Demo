//
//  BallDemoView.swift
//  GraphMetal-Demo
//
//  Created by Jim Hanson on 11/29/21.
//

import SwiftUI
import GraphMetal

struct BallDemoView: View {

    @ObservedObject var demo: BallDemo

    var body: some View {
        NavigationView {
            BallSettingsView(demo)
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

    init(_ demo: BallDemo) {
        self.demo = demo
    }
}

struct BallSettingsView: View {

    @ObservedObject var demo: BallDemo

    var body: some View {
        Text("BallSettings")
    }

    init(_ demo: BallDemo) {
        self.demo = demo
    }
}

////
////  BallSettingsView.swift
////  GraphMetal-Demo
////
////  Created by Jim Hanson on 5/10/21.
////
//
//import SwiftUI
//
//struct BallSettingsView : View {
//
//    @ObservedObject var demo: BallDemo
//
//    // @State var group = SettingsGroup().itemStyle(.narrow)
//
//    var body: some View {
//        VStack(alignment: .center) {
//
//            HStack {
//                Button(action: { demo.growing = true }) {
//                    Text("Start")
//                }
//                // .foregroundColor(UIConstants.controlColor)
//                // .modifier(SymbolButtonStyle())
//
//                Button(action: { demo.growing = false }) {
//                    Text("Stop")
//                }
//                // .foregroundColor(UIConstants.controlColor)
//                // .modifier(SymbolButtonStyle())
//            }
//
//            Text("#nodes: \(demo.nodeCount)")
//
//            Text("#edges: \(demo.edgeCount)")
//
//        }.frame(maxWidth: .infinity, maxHeight: .infinity)
//    }
//
//    init(_ demo: BallDemo) {
//        self.demo = demo
//    }
//}
