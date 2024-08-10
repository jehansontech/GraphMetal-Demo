//
//  ColoredNodesControls.swift
//  GraphMetal-Demo
//
//  Created by Jim Hanson on 7/30/24.
//

import SwiftUI
import GraphMetal
import Wacoma

struct ColoredNodesControls: View {

    static var labelWidth: CGFloat = 90

    @ObservedObject var demo: ColoredNodesDemo

    @State var nodeSizeIsExpanded = false

    @State var edgeColorIsExpanded = false

    @State var backgroundColorIsExpanded = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {

                DisclosureGroup("Node Size", isExpanded: $nodeSizeIsExpanded) {
                    HStack {
                        Divider()
                        ColoredNodesNodeSizeControls(demo: demo)
                    }
                    .onAppear {
                        // unexpand the others
                        edgeColorIsExpanded = false
                        backgroundColorIsExpanded = false
                    }
                    .padding(.leading, 2)
                }

                DisclosureGroup("Edge Color", isExpanded: $edgeColorIsExpanded) {
                    HStack {
                        Divider()
                        ColoredNodesEdgeColorControls(demo: demo)
                    }
                    .onAppear {
                        // unexpand the others
                        nodeSizeIsExpanded = false
                        backgroundColorIsExpanded = false
                    }
                    .padding(.leading, 2)
                }

                DisclosureGroup("Background Color", isExpanded: $backgroundColorIsExpanded) {
                    HStack {
                        Divider()
                        ColoredNodesBackgroundColorControls(demo: demo)
                    }
                    .onAppear {
                        // unexpand the others
                        nodeSizeIsExpanded = false
                        edgeColorIsExpanded = false
                    }
                    .padding(.leading, 2)
                }
            }
        }
    }
}

struct ColoredNodesNodeSizeControls: View {

    private var nodeSizeRange: ClosedRange<Float> { ZWireframeConstants.pointSizeMinimum...ZWireframeConstants.pointSizeMaximum }

    @ObservedObject var demo: ColoredNodesDemo

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Node Size")
                    .frame(width: ColoredNodesControls.labelWidth, alignment: .trailing)
                Slider(value: $demo.wireframe.nodeSize, in: nodeSizeRange) {
                    Text("")
                }
            }
        }
    }
}

struct ColoredNodesEdgeColorControls: View {

    @ObservedObject var demo: ColoredNodesDemo

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Red")
                    .frame(width: ColoredNodesControls.labelWidth, alignment: .trailing)
                Slider(value: $demo.wireframe.defaultElementColor.x, in: 0...1) {
                    Text("")
                }
            }

            HStack {
                Text("Green")
                    .frame(width: ColoredNodesControls.labelWidth, alignment: .trailing)
                Slider(value: $demo.wireframe.defaultElementColor.y, in: 0...1) {
                    Text("")
                }
            }

            HStack {
                Text("Blue")
                    .frame(width: ColoredNodesControls.labelWidth, alignment: .trailing)
                Slider(value: $demo.wireframe.defaultElementColor.z, in: 0...1) {
                    Text("")
                }
            }

            HStack {
                Text("Alpha")
                    .frame(width: ColoredNodesControls.labelWidth, alignment: .trailing)
                Slider(value: $demo.wireframe.defaultElementColor.w, in: 0...1) {
                    Text("")
                }
            }
        }
    }
}

struct ColoredNodesBackgroundColorControls: View {

    @ObservedObject var demo: ColoredNodesDemo

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Red")
                    .frame(width: ColoredNodesControls.labelWidth, alignment: .trailing)
                Slider(value: $demo.renderer.backgroundColor.x, in: 0...1) {
                    Text("")
                }
            }

            HStack {
                Text("Green")
                    .frame(width: ColoredNodesControls.labelWidth, alignment: .trailing)
                Slider(value: $demo.renderer.backgroundColor.y, in: 0...1) {
                    Text("")
                }
            }

            HStack {
                Text("Blue")
                    .frame(width: ColoredNodesControls.labelWidth, alignment: .trailing)
                Slider(value: $demo.renderer.backgroundColor.z, in: 0...1) {
                    Text("")
                }
            }

            HStack {
                Text("Alpha")
                    .frame(width: ColoredNodesControls.labelWidth, alignment: .trailing)
                Slider(value: $demo.renderer.backgroundColor.w, in: 0...1) {
                    Text("")
                }
            }
        }
    }
}

