//
//  WireframeDemoControls.swift
//  GraphMetal-Demo
//
//  Created by Jim Hanson on 12/13/21.
//

import SwiftUI
import Wacoma

struct WireframeDemoControls: View {

    static var labelWidth: CGFloat = 80

    var demo: WireframeDemo

    @State var nodeSizeIsExpanded = false
    @State var nodeColorDefaultIsExpanded = false
    @State var edgeColorIsExpanded = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {

                DisclosureGroup("Node size", isExpanded: $nodeSizeIsExpanded) {
                    HStack {
                        Divider()
                        NodeSizeControls(demo: demo)
                    }
                    .padding(.leading, 2)
                }

                DisclosureGroup("Node color default",  isExpanded: $nodeColorDefaultIsExpanded) {
                    HStack {
                        Divider()
                        NodeColorDefaultControls(demo: demo)
                    }
                    .padding(.leading, 2)
                }

                DisclosureGroup("Edge color", isExpanded: $edgeColorIsExpanded) {
                    HStack {
                        Divider()
                        EdgeColorControls(demo: demo)
                    }
                    .padding(.leading, 2)
                }

                HStack {
                    Button {
                        nodeSizeIsExpanded = false
                        nodeColorDefaultIsExpanded = false
                        edgeColorIsExpanded = false
                        demo.wireframeSettings.reset()
                    } label: {
                        Text("Reset all")
                    }
                }
                .padding(.top, 5)
                .frame(maxWidth: .infinity)

                Spacer()
            }
        }
    }
}


struct NodeSizeControls: View {

    var demo: WireframeDemo

    @State var isAdjustedText: String = ""

    @State var nodeSizeDefault: Double = 1

    @State var nodeSizeMinimum: Double = 1

    @State var nodeSizeMaximum: Double = 1


    var body: some View {
        VStack(alignment: .leading, spacing: 0) {

            HStack {
                Text("Adjusted")
                    .frame(width: WireframeDemoControls.labelWidth, alignment: .trailing)

                Button {
                    demo.wireframeSettings.nodeSizeIsAdjusted.toggle()
                    updateIsAdjustedText()
                } label: {
                    Text(isAdjustedText)
                        .frame(maxWidth: .infinity)
                }
                .onAppear {
                    updateIsAdjustedText()
                }
            }

            HStack {
                Text("Default")
                    .frame(width: WireframeDemoControls.labelWidth, alignment: .trailing)

                Slider(value: $nodeSizeDefault, in: 1...200) {
                    Text("")
                } minimumValueLabel: {
                    Text("1")
                } maximumValueLabel: {
                    Text("200")
                } onEditingChanged: { editing in
                    if !editing {
                        demo.wireframeSettings.nodeSizeDefault = nodeSizeDefault
                        demo.updateGraph()
                    }
                }
                .onAppear {
                    nodeSizeDefault = demo.wireframeSettings.nodeSizeDefault
                }
            }

            HStack {
                Text("Minimum")
                    .frame(width: WireframeDemoControls.labelWidth, alignment: .trailing)

                Slider(value: $nodeSizeMinimum, in: 1...200) {
                    Text("")
                } minimumValueLabel: {
                    Text("1")
                } maximumValueLabel: {
                    Text("200")
                } onEditingChanged: { editing in
                    if !editing {
                        demo.wireframeSettings.nodeSizeMinimum = nodeSizeMinimum
                        demo.updateGraph()
                    }
                }
                .onAppear {
                    nodeSizeMinimum = demo.wireframeSettings.nodeSizeMinimum
                }
            }

            HStack {
                Text("Maximum")
                    .frame(width: WireframeDemoControls.labelWidth, alignment: .trailing)

                Slider(value: $nodeSizeMaximum, in: 1...200) {
                    Text("")
                } minimumValueLabel: {
                    Text("1")
                } maximumValueLabel: {
                    Text("200")
                } onEditingChanged: { editing in
                    if !editing {
                        demo.wireframeSettings.nodeSizeMaximum = nodeSizeMaximum
                        demo.updateGraph()
                    }
                }
                .onAppear {
                    nodeSizeMaximum = demo.wireframeSettings.nodeSizeMaximum
                }
            }
        }
    }

    func updateIsAdjustedText() {
        if demo.wireframeSettings.nodeSizeIsAdjusted {
            isAdjustedText = "Yes"
        }
        else {
            isAdjustedText = "No"
        }
    }
}

struct NodeColorDefaultControls: View {

    var demo: WireframeDemo

    @State var red: Float = 0.5
    @State var green: Float = 0.5
    @State var blue: Float = 0.5
    @State var alpha: Float = 1

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Red")
                    .frame(width: WireframeDemoControls.labelWidth, alignment: .trailing)

                Slider(value: $red, in: 0...1) {
                    Text("")
                } minimumValueLabel: {
                    Text("0")
                } maximumValueLabel: {
                    Text("1")
                } onEditingChanged: { editing in
                    if !editing {
                        demo.wireframeSettings.nodeColorDefault.x = red
                        demo.updateGraph()
                    }
                }
                .onAppear {
                    red = demo.wireframeSettings.nodeColorDefault.x
                }
            }
            HStack {
                Text("Green")
                    .frame(width: WireframeDemoControls.labelWidth, alignment: .trailing)

                Slider(value: $green, in: 0...1) {
                    Text("")
                } minimumValueLabel: {
                    Text("0")
                } maximumValueLabel: {
                    Text("1")
                } onEditingChanged: { editing in
                    if !editing {
                        demo.wireframeSettings.nodeColorDefault.y = green
                        demo.updateGraph()
                    }
                }
                .onAppear {
                    green = demo.wireframeSettings.nodeColorDefault.y
                }
            }

            HStack {
                Text("Blue")
                    .frame(width: WireframeDemoControls.labelWidth, alignment: .trailing)

                Slider(value: $blue, in: 0...1) {
                    Text("")
                } minimumValueLabel: {
                    Text("0")
                } maximumValueLabel: {
                    Text("1")
                } onEditingChanged: { editing in
                    if !editing {
                        demo.wireframeSettings.nodeColorDefault.z = blue
                        demo.updateGraph()
                    }                }
                .onAppear {
                    blue = demo.wireframeSettings.nodeColorDefault.z
                }
            }

            HStack {
                Text("Opacity")
                    .frame(width: WireframeDemoControls.labelWidth, alignment: .trailing)

                Slider(value: $alpha, in: 0...1) {
                    Text("")
                } minimumValueLabel: {
                    Text("0")
                } maximumValueLabel: {
                    Text("1")
                } onEditingChanged: { editing in
                    if !editing {
                        demo.wireframeSettings.nodeColorDefault.w = alpha
                        demo.updateGraph()
                    }
                }
                .onAppear {
                    alpha = demo.wireframeSettings.nodeColorDefault.w
                }
            }
        }
    }
}

struct EdgeColorControls: View {

    var demo: WireframeDemo

    @State var red: Float = 0.5
    @State var green: Float = 0.5
    @State var blue: Float = 0.5
    @State var alpha: Float = 1

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Red")
                    .frame(width: WireframeDemoControls.labelWidth, alignment: .trailing)

                Slider(value: $red, in: 0...1) {
                    Text("")
                } minimumValueLabel: {
                    Text("0")
                } maximumValueLabel: {
                    Text("1")
                } onEditingChanged: { editing in
                    if !editing {
                        demo.wireframeSettings.edgeColor.x = red
                        demo.updateGraph()
                    }
                }
                .onAppear {
                    red = demo.wireframeSettings.edgeColor.x
                }
            }
            HStack {
                Text("Green")
                    .frame(width: WireframeDemoControls.labelWidth, alignment: .trailing)

                Slider(value: $green, in: 0...1) {
                    Text("")
                } minimumValueLabel: {
                    Text("0")
                } maximumValueLabel: {
                    Text("1")
                } onEditingChanged: { editing in
                    if !editing {
                        demo.wireframeSettings.edgeColor.y = green
                        demo.updateGraph()
                    }
                }
                .onAppear {
                    green = demo.wireframeSettings.edgeColor.y
                }
            }

            HStack {
                Text("Blue")
                    .frame(width: WireframeDemoControls.labelWidth, alignment: .trailing)

                Slider(value: $blue, in: 0...1) {
                    Text("")
                } minimumValueLabel: {
                    Text("0")
                } maximumValueLabel: {
                    Text("1")
                } onEditingChanged: { editing in
                    if !editing {
                        demo.wireframeSettings.edgeColor.z = blue
                        demo.updateGraph()
                    }
                }
                .onAppear {
                    blue = demo.wireframeSettings.edgeColor.z
                }
            }

            HStack {
                Text("Opacity")
                    .frame(minWidth: WireframeDemoControls.labelWidth, alignment: .trailing)

                Slider(value: $alpha, in: 0...1) {
                    Text("")
                } minimumValueLabel: {
                    Text("0")
                } maximumValueLabel: {
                    Text("1")
                } onEditingChanged: { editing in
                    if !editing {
                        demo.wireframeSettings.edgeColor.w = alpha
                        demo.updateGraph()
                    }
                }
                .onAppear {
                    alpha = demo.wireframeSettings.edgeColor.w
                }
            }
        }
    }
}


