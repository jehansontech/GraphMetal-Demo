////
////  XWireframeControls.swift
////  GraphMetal-Demo
////
////  Created by Jim Hanson on 8/15/24.
////
//
//import SwiftUI
//import GraphMetal
//import Wacoma
//
//struct XWireframeControls: View {
//
//    static var labelWidth: CGFloat = 90
//
//    @ObservedObject var demo: XWireframeDemo
//
//    @State var isGraphSettingsExpanded = false
//
//    @State var isBackgroundSettingsExpanded = false
//
//    @State var isFOVSettingsExpanded = false
//
//    var body: some View {
//        ScrollView {
//            VStack(alignment: .leading, spacing: 0) {
//
//                DisclosureGroup("Graph", isExpanded: $isGraphSettingsExpanded) {
//                    HStack {
//                        Divider()
//                        XWireframeGraphSettingsControls(demo: demo)
//                    }
//                    .onAppear {
//                        // unexpand the others
//                        isBackgroundSettingsExpanded = false
//                        isFOVSettingsExpanded = false
//                    }
//                    .padding(.leading, 2)
//                }
//
//                DisclosureGroup("Background", isExpanded: $isBackgroundSettingsExpanded) {
//                    HStack {
//                        Divider()
//                        XWireframeBackgroundSettingsControls(demo: demo)
//                    }
//                    .onAppear {
//                        // unexpand the others
//                        isGraphSettingsExpanded = false
//                        isFOVSettingsExpanded = false
//                    }
//                    .padding(.leading, 2)
//                }
//
//                DisclosureGroup("Field of View", isExpanded: $isFOVSettingsExpanded) {
//                    HStack {
//                        Divider()
//                        XWireframeFOVSettingsControls(fovController: demo.fovController)
//                    }
//                    .onAppear {
//                        // unexpand the others
//                        isGraphSettingsExpanded = false
//                        isBackgroundSettingsExpanded = false
//                    }
//                    .padding(.leading, 2)
//                }
//
//            }
//        }
//    }
//}
//
//struct XWireframeGraphSettingsControls: View {
//
//    private var nodeSizeRange: ClosedRange<Float> { ZWireframeConstants.pointSizeMinimum...ZWireframeConstants.pointSizeMaximum }
//
//    @ObservedObject var demo: XWireframeDemo
//
//    var body: some View {
//        VStack(alignment: .leading) {
////            HStack {
////                Text("Node Size")
////                    .frame(width: XWireframeControls.labelWidth, alignment: .trailing)
////                Slider(value: $demo.wireframe.nodeSize, in: nodeSizeRange) {
////                    Text("")
////                }
////            }
////            Text("Edge Color")
////            VStack(alignment: .leading) {
////                HStack {
////                    Text("Red")
////                        .frame(width: XWireframeControls.labelWidth, alignment: .trailing)
////                    Slider(value: $demo.wireframe.edgeColor.x, in: 0...1) {
////                        Text("")
////                    }
////                }
////
////                HStack {
////                    Text("Green")
////                        .frame(width: XWireframeControls.labelWidth, alignment: .trailing)
////                    Slider(value: $demo.wireframe.edgeColor.y, in: 0...1) {
////                        Text("")
////                    }
////                }
////
////                HStack {
////                    Text("Blue")
////                        .frame(width: XWireframeControls.labelWidth, alignment: .trailing)
////                    Slider(value: $demo.wireframe.edgeColor.z, in: 0...1) {
////                        Text("")
////                    }
////                }
////
////                HStack {
////                    Text("Alpha")
////                        .frame(width: XWireframeControls.labelWidth, alignment: .trailing)
////                    Slider(value: $demo.wireframe.edgeColor.w, in: 0...1) {
////                        Text("")
////                    }
////                }
////            }
//        }
//    }
//}
//
//struct XWireframeBackgroundSettingsControls: View {
//
//    @ObservedObject var demo: XWireframeDemo
//
//    var body: some View {
//        VStack(alignment: .leading) {
////            Text("Color")
////            VStack(alignment: .leading) {
////                HStack {
////                    Text("Red")
////                        .frame(width: XWireframeControls.labelWidth, alignment: .trailing)
////                    Slider(value: $demo.renderer.backgroundColor.x, in: 0...1) {
////                        Text("")
////                    }
////                }
////
////                HStack {
////                    Text("Green")
////                        .frame(width: XWireframeControls.labelWidth, alignment: .trailing)
////                    Slider(value: $demo.renderer.backgroundColor.y, in: 0...1) {
////                        Text("")
////                    }
////                }
////
////                HStack {
////                    Text("Blue")
////                        .frame(width: XWireframeControls.labelWidth, alignment: .trailing)
////                    Slider(value: $demo.renderer.backgroundColor.z, in: 0...1) {
////                        Text("")
////                    }
////                }
////
////                HStack {
////                    Text("Alpha")
////                        .frame(width: XWireframeControls.labelWidth, alignment: .trailing)
////                    Slider(value: $demo.renderer.backgroundColor.w, in: 0...1) {
////                        Text("")
////                    }
////                }
////            }
//        }
//    }
//}
//
//struct XWireframeFOVSettingsControls: View {
//
//    let yFOVMin: Float = 0.01 * Float.pi
//    let yFOVMax: Float = 0.99 * Float.pi
//
//    @ObservedObject var fovController: PerspectiveFOVController
//
//    var body: some View {
//        VStack(alignment: .leading) {
//            Text("Fadeout")
//            VStack(alignment: .leading) {
//                HStack {
//                    Text("Midpoint")
//                        .frame(width: XWireframeControls.labelWidth, alignment: .trailing)
//                    Slider(value: $fovController.fadeoutMidpoint, in: 1...20)
//                }
//                HStack {
//                    Text("Distance")
//                        .frame(width: XWireframeControls.labelWidth, alignment: .trailing)
//                    Slider(value: $fovController.fadeoutDistance, in: 1...10)
//                }
//            }
//
//            Text("FOVController")
//            VStack(alignment: .leading) {
//                HStack {
//                    Text("zNear")
//                        .frame(width: XWireframeControls.labelWidth, alignment: .trailing)
//                    Slider(value: $fovController.zNear, in: 0.01...9.99) {
//                        Text("")
//                    }
//                }
//
//                HStack {
//                    Text("zFar")
//                        .frame(width: XWireframeControls.labelWidth, alignment: .trailing)
//                    Slider(value: $fovController.zFar, in: 10...100) {
//                        Text("")
//                    }
//                }
//
//                HStack {
//                    Text("yFOV")
//                        .frame(width: XWireframeControls.labelWidth, alignment: .trailing)
//                    Slider(value: $fovController.yFOV, in: yFOVMin...yFOVMax) {
//                        Text("")
//                    }
//                }
//            }
//        }
//    }
//}
