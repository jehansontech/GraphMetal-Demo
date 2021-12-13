////
////  CubeDemoView.swift
////  GraphMetal-Demo
////
////  Created by Jim Hanson on 11/29/21.
////
//
//import SwiftUI
//import Wacoma
//import GraphMetal
//
//struct CubeSettingsView: View {
//
//    @ObservedObject var demo: CubeDemo
//
//    var body: some View {
//        ScrollView {
//            VStack(alignment: .leading, spacing: 0) {
//
////                DisclosureGroup("Node size") {
////                    HStack {
////                        Divider()
////                        NodeSizeControls(demo: demo)
////                    }
////                    .padding(.leading, 2)
////                }
////
////                DisclosureGroup("Node color default") {
////                    HStack {
////                        Divider()
////                        NodeColorDefaultControls(demo: demo)
////                    }
////                    .padding(.leading, 2)
////                }
////
////                DisclosureGroup("Edge color") {
////                    HStack {
////                        Divider()
////                        EdgeColorControls(color: $demo.wireframeSettings.edgeColor)
////                    }
////                    .padding(.leading, 2)
////                }
//
//                DisclosureGroup("Orbit") {
//                    HStack {
//                        Divider()
//                        OrbitControls(demo: demo)
//                    }
//                    .padding(.leading, 2)
//                }
//
//                Spacer()
//            }
//        }
//    }
//
//    init(_ cube: CubeDemo) {
//        self.demo = cube
//    }
//}
//
//struct CubeDisplayView: View {
//
//    @ObservedObject var cube: CubeDemo
//
//    var body: some View {
//        GraphView(cube,
//                  renderController: cube.renderController,
//                  povController: cube.povController)
//            .onAppear {
//                cube.setup()
//            }
//    }
//
//    init(_ cube: CubeDemo) {
//        self.cube = cube
//    }
//}
//
//
////struct NodeColorControls: View {
////
////    @ObservedObject var demo: CubeDemo
////
////    var body: some View {
////        VStack {
////        }
////        VStack {
////            HStack {
////                Text("R")
////                Slider(value: $demo.red, in: 0...1) {
////                    Text("")
////                } minimumValueLabel: {
////                    Text("0")
////                } maximumValueLabel: {
////                    Text("1")
////                }
////            }
////            HStack {
////                Text("G")
////                Slider(value: $demo.green, in: 0...1) {
////                    Text("")
////                } minimumValueLabel: {
////                    Text("0")
////                } maximumValueLabel: {
////                    Text("1")
////                }
////            }
////            HStack {
////                Text("B")
////                Slider(value: $demo.blue, in: 0...1) {
////                    Text("")
////                } minimumValueLabel: {
////                    Text("0")
////                } maximumValueLabel: {
////                    Text("1")
////                }
////            }
////        }
////    }
////}
//
//struct OrbitControls: View {
//
//    @ObservedObject var demo: CubeDemo
//
//    var body: some View {
//        VStack(alignment: .leading) {
//            Toggle("Enabled", isOn: $demo.povController.orbitEnabled)
//                .toggleStyle(.switch)
//            HStack {
//                Text("Speed")
//                Slider(value: $demo.povController.orbitSpeed, in: -1...1)  {
//                    Text("")
//                } minimumValueLabel: {
//                    Text("-1")
//                } maximumValueLabel: {
//                    Text("1")
//                }
//            }
//        }
//    }
//}
