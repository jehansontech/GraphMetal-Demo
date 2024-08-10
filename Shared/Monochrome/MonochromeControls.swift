//
//  MonochromeControls.swift
//  GraphMetal-Demo
//
//  Created by Jim Hanson on 8/10/24.
//

import SwiftUI
import GraphMetal
import Wacoma

struct MonochromeControls: View {

    static var labelWidth: CGFloat = 90

    @ObservedObject var demo: MonochromeDemo

    @State var nodeSizeIsExpanded = false

    @State var graphColorIsExpanded = false

    @State var backgroundColorIsExpanded = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {

                DisclosureGroup("Node Size", isExpanded: $nodeSizeIsExpanded) {
                    HStack {
                        Divider()
                        MonochromeSettingsNodeSizeControls(demo: demo)
                    }
                    .onAppear {
                        // unexpand the others
                        graphColorIsExpanded = false
                        backgroundColorIsExpanded = false
                    }
                    .padding(.leading, 2)
                }

                DisclosureGroup("Graph Color", isExpanded: $graphColorIsExpanded) {
                    HStack {
                        Divider()
                        MonochromeSettingsGraphColorControls(demo: demo)
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
                        MonochromeSettingsBackgroundColorControls(demo: demo)
                    }
                    .onAppear {
                        // unexpand the others
                        nodeSizeIsExpanded = false
                        graphColorIsExpanded = false
                    }
                    .padding(.leading, 2)
                }
            }
        }
    }
}

struct MonochromeSettingsNodeSizeControls: View {

    private var nodeSizeRange: ClosedRange<Float> { ZWireframeConstants.pointSizeMinimum...ZWireframeConstants.pointSizeMaximum }

    @ObservedObject var demo: MonochromeDemo

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Point Size")
                    .frame(width: MonochromeControls.labelWidth, alignment: .trailing)
                Slider(value: $demo.wireframe.nodeSize, in: nodeSizeRange) {
                    Text("")
                }
            }
        }
    }
}

struct MonochromeSettingsGraphColorControls: View {

    @ObservedObject var demo: MonochromeDemo

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Red")
                    .frame(width: MonochromeControls.labelWidth, alignment: .trailing)
                Slider(value: $demo.wireframe.defaultElementColor.x, in: 0...1) {
                    Text("")
                }
            }

            HStack {
                Text("Green")
                    .frame(width: MonochromeControls.labelWidth, alignment: .trailing)
                Slider(value: $demo.wireframe.defaultElementColor.y, in: 0...1) {
                    Text("")
                }
            }

            HStack {
                Text("Blue")
                    .frame(width: MonochromeControls.labelWidth, alignment: .trailing)
                Slider(value: $demo.wireframe.defaultElementColor.z, in: 0...1) {
                    Text("")
                }
            }

            HStack {
                Text("Alpha")
                    .frame(width: MonochromeControls.labelWidth, alignment: .trailing)
                Slider(value: $demo.wireframe.defaultElementColor.w, in: 0...1) {
                    Text("")
                }
            }
        }
    }
}

struct MonochromeSettingsBackgroundColorControls: View {

    @ObservedObject var demo: MonochromeDemo

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Red")
                    .frame(width: MonochromeControls.labelWidth, alignment: .trailing)
                Slider(value: $demo.renderer.backgroundColor.x, in: 0...1) {
                    Text("")
                }
            }

            HStack {
                Text("Green")
                    .frame(width: MonochromeControls.labelWidth, alignment: .trailing)
                Slider(value: $demo.renderer.backgroundColor.y, in: 0...1) {
                    Text("")
                }
            }

            HStack {
                Text("Blue")
                    .frame(width: MonochromeControls.labelWidth, alignment: .trailing)
                Slider(value: $demo.renderer.backgroundColor.z, in: 0...1) {
                    Text("")
                }
            }

            HStack {
                Text("Alpha")
                    .frame(width: MonochromeControls.labelWidth, alignment: .trailing)
                Slider(value: $demo.renderer.backgroundColor.w, in: 0...1) {
                    Text("")
                }
            }
        }
    }
}

