//
//  ZWireframeControls.swift
//  GraphMetal-Demo
//
//  Created by Jim Hanson on 7/30/24.
//

import SwiftUI
import GraphMetal
import Wacoma

struct ZWireframeControls: View {

    static var labelWidth: CGFloat = 90

    @ObservedObject var demo: ZWireframeDemo

    @State var graphColorIsExpanded = false

    @State var backgroundColorIsExpanded = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {

                DisclosureGroup("Graph Color", isExpanded: $graphColorIsExpanded) {
                    HStack {
                        Divider()
                        ZWireframeGraphColorControls(demo: demo)
                    }
                    .onAppear {
                        // unexpand the others
                        backgroundColorIsExpanded = false
                    }
                    .padding(.leading, 2)
                }

                DisclosureGroup("Background Color", isExpanded: $backgroundColorIsExpanded) {
                    HStack {
                        Divider()
                        ZWireframeBackgroundColorControls(demo: demo)
                    }
                    .onAppear {
                        // unexpand the others
                        graphColorIsExpanded = false
                    }
                    .padding(.leading, 2)
                }
            }
        }
    }
}

struct ZWireframeGraphColorControls: View {

    @ObservedObject var demo: ZWireframeDemo

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Red")
                    .frame(width: ZWireframeControls.labelWidth, alignment: .trailing)
                Slider(value: $demo.renderer.settings.defaultEdgeColor.x, in: 0...1) {
                    Text("")
                }
            }

            HStack {
                Text("Green")
                    .frame(width: ZWireframeControls.labelWidth, alignment: .trailing)
                Slider(value: $demo.renderer.settings.defaultEdgeColor.y, in: 0...1) {
                    Text("")
                }
            }

            HStack {
                Text("Blue")
                    .frame(width: ZWireframeControls.labelWidth, alignment: .trailing)
                Slider(value: $demo.renderer.settings.defaultEdgeColor.z, in: 0...1) {
                    Text("")
                }
            }

            HStack {
                Text("Alpha")
                    .frame(width: ZWireframeControls.labelWidth, alignment: .trailing)
                Slider(value: $demo.renderer.settings.defaultEdgeColor.w, in: 0...1) {
                    Text("")
                }
            }
        }
    }
}

struct ZWireframeBackgroundColorControls: View {

    @ObservedObject var demo: ZWireframeDemo

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Red")
                    .frame(width: ZWireframeControls.labelWidth, alignment: .trailing)
                Slider(value: $demo.renderer.settings.backgroundColor.x, in: 0...1) {
                    Text("")
                }
            }

            HStack {
                Text("Green")
                    .frame(width: ZWireframeControls.labelWidth, alignment: .trailing)
                Slider(value: $demo.renderer.settings.backgroundColor.y, in: 0...1) {
                    Text("")
                }
            }

            HStack {
                Text("Blue")
                    .frame(width: ZWireframeControls.labelWidth, alignment: .trailing)
                Slider(value: $demo.renderer.settings.backgroundColor.z, in: 0...1) {
                    Text("")
                }
            }

            HStack {
                Text("Alpha")
                    .frame(width: ZWireframeControls.labelWidth, alignment: .trailing)
                Slider(value: $demo.renderer.settings.backgroundColor.w, in: 0...1) {
                    Text("")
                }
            }
        }
    }
}

