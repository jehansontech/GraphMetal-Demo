//
//  Settings2DemoControls.swift
//  GraphMetal-Demo
//
//  Created by Jim Hanson on 12/13/21.
//

import SwiftUI
import Wacoma

struct SettingsDemoControls: View {

    static var labelWidth: CGFloat = 90

    @ObservedObject var demo: SettingsDemo

    @State var nodeSizeIsExpanded = false

    @State var nodeColorDefaultIsExpanded = false

    @State var edgeColorIsExpanded = false

    @State var backgroundColorIsExpanded = false

    @State var projectionIsExpanded = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {

                DisclosureGroup("Node size", isExpanded: $nodeSizeIsExpanded) {
                    HStack {
                        Divider()
                        NodeSizeControls(demo: demo)
                    }
                    .onAppear {
                        nodeColorDefaultIsExpanded = false
                        edgeColorIsExpanded = false
                        backgroundColorIsExpanded = false
                        projectionIsExpanded = false
                    }
                    .padding(.leading, 2)
                }

                DisclosureGroup("Node color default",  isExpanded: $nodeColorDefaultIsExpanded) {
                    HStack {
                        Divider()
                        NodeColorDefaultControls(demo: demo)
                    }
                    .onAppear {
                        nodeSizeIsExpanded = false
                        edgeColorIsExpanded = false
                        backgroundColorIsExpanded = false
                        projectionIsExpanded = false
                    }
                    .padding(.leading, 2)
                }

                DisclosureGroup("Edge color", isExpanded: $edgeColorIsExpanded) {
                    HStack {
                        Divider()
                        EdgeColorControls(demo: demo)
                    }
                    .onAppear {
                        nodeSizeIsExpanded = false
                        nodeColorDefaultIsExpanded = false
                        backgroundColorIsExpanded = false
                        projectionIsExpanded = false
                    }
                    .padding(.leading, 2)
                }

                DisclosureGroup("Background Color", isExpanded: $backgroundColorIsExpanded) {
                    HStack {
                        Divider()
                        BackgroundColorControls(demo: demo)
                    }
                    .onAppear {
                        nodeSizeIsExpanded = false
                        edgeColorIsExpanded = false
                        nodeColorDefaultIsExpanded = false
                        projectionIsExpanded = false
                    }
                    .padding(.leading, 2)
                }

                DisclosureGroup("Field of view", isExpanded: $projectionIsExpanded) {
                    HStack {
                        Divider()
                        ProjectionControls(demo: demo)
                    }
                    .onAppear {
                        nodeSizeIsExpanded = false
                        edgeColorIsExpanded = false
                        nodeColorDefaultIsExpanded = false
                    }
                    .padding(.leading, 2)
                }
            }
        }
    }
}


struct NodeSizeControls: View {

    var demo: SettingsDemo

    @State var nodeSizeIsAdjusted: Bool = true

    @State var nodeSize: Double = 1

    @State var nodeSizeMinimum: Double = 1

    @State var nodeSizeMaximum: Double = 1

    var isAdjustedText: String {
        return nodeSizeIsAdjusted ? "Yes" : "No"
    }

    var sizeScaleButtonText: String {
        return nodeSizeIsAdjusted ? "Scale" : "Size"
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 2) {

            Text("Node size can change automatically as you zoom in or out, or you can set it manually")
                .padding(.bottom, 10)

            HStack {
                Text("Automatically adjusted")
                    .frame(width: SettingsDemoControls.labelWidth, alignment: .trailing)

                Button {
                    nodeSizeIsAdjusted.toggle()
                    demo.wireframe.settings.nodeSizeIsAdjusted = nodeSizeIsAdjusted
                } label: {
                    Text(isAdjustedText)
                }
                .onAppear {
                    self.nodeSizeIsAdjusted = demo.wireframe.settings.nodeSizeIsAdjusted
                }
                .frame(maxWidth: .infinity, alignment: .center)
            }

            HStack {
                Text("Minimum")
                    .frame(width: SettingsDemoControls.labelWidth, alignment: .trailing)

                Slider(value: $nodeSizeMinimum, in: 1...200) {
                    Text("")
                } onEditingChanged: { editing in
                    if !editing {
                        demo.wireframe.settings.nodeSizeMinimum = nodeSizeMinimum
                    }
                }
                .onAppear {
                    nodeSizeMinimum = demo.wireframe.settings.nodeSizeMinimum
                }
            }

            HStack {
                Text("Maximum")
                    .frame(width: SettingsDemoControls.labelWidth, alignment: .trailing)

                Slider(value: $nodeSizeMaximum, in: 1...200) {
                    Text("")
                } onEditingChanged: { editing in
                    if !editing {
                        demo.wireframe.settings.nodeSizeMaximum = nodeSizeMaximum
                    }
                }
                .onAppear {
                    nodeSizeMaximum = demo.wireframe.settings.nodeSizeMaximum
                }
            }

            HStack {
                Text(sizeScaleButtonText)
                    .frame(width: SettingsDemoControls.labelWidth, alignment: .trailing)

                Slider(value: $nodeSize, in: 1...200) {
                    Text("")
                } onEditingChanged: { editing in
                    if !editing {
                        demo.wireframe.settings.nodeSize = nodeSize
                    }
                }
                .onAppear {
                    nodeSize = demo.wireframe.settings.nodeSize
                }
            }
        }
    }
}

struct NodeColorDefaultControls: View {

    var demo: SettingsDemo

    @State var red: Float = 0
    @State var green: Float = 0
    @State var blue: Float = 0
    @State var alpha: Float = 1

    var body: some View {
        VStack(alignment: .leading) {

            Text("Node color default is used when a node's own color is not set (as in this case)")
                .padding(.bottom, 10)

            HStack {
                Text("Red")
                    .frame(width: SettingsDemoControls.labelWidth, alignment: .trailing)


                Slider(value: $red, in: 0...1) {
                    Text("")
                }
                .onAppear {
                    red = demo.wireframe.settings.nodeColorDefault.x
                }
                .onChange(of: red) { newValue in
                    demo.wireframe.settings.nodeColorDefault.x = Float(newValue)
                    demo.updateGraph(.color)
                }
            }
            HStack {
                Text("Green")
                    .frame(width: SettingsDemoControls.labelWidth, alignment: .trailing)

                Slider(value: $green, in: 0...1) {
                    Text("")
                }
                .onAppear {
                    green = demo.wireframe.settings.nodeColorDefault.y
                }
                .onChange(of: green) { newValue in
                    demo.wireframe.settings.nodeColorDefault.y = Float(newValue)
                    demo.updateGraph(.color)
                }
            }

            HStack {
                Text("Blue")
                    .frame(width: SettingsDemoControls.labelWidth, alignment: .trailing)

                Slider(value: $blue, in: 0...1) {
                    Text("")
                }
                .onAppear {
                    blue = demo.wireframe.settings.nodeColorDefault.z
                }
                .onChange(of: blue) { newValue in
                    demo.wireframe.settings.nodeColorDefault.z = Float(newValue)
                    demo.updateGraph(.color)
                }
            }

            HStack {
                Text("Alpha")
                    .frame(width: SettingsDemoControls.labelWidth, alignment: .trailing)

                Slider(value: $alpha, in: 0...1) {
                    Text("")
                }
                .onAppear {
                    alpha = demo.wireframe.settings.nodeColorDefault.w
                }
                .onChange(of: alpha) { newValue in
                    demo.wireframe.settings.nodeColorDefault.w = Float(newValue)
                    demo.updateGraph(.color)
                }
            }
        }
    }
}

struct EdgeColorControls: View {

    var demo: SettingsDemo

    @State var red: Float = 0

    @State var green: Float = 0

    @State var blue: Float = 0

    @State var alpha: Float = 1

    var body: some View {
        VStack(alignment: .leading) {

            Text("All edges have the same color")
                .padding(.bottom, 10)

            HStack {
                Text("Red")
                    .frame(width: SettingsDemoControls.labelWidth, alignment: .trailing)

                Slider(value: $red, in: 0...1) {
                    Text("")
                }
                .onAppear {
                    red = demo.wireframe.settings.edgeColor.x
                }
                .onChange(of: red) { newValue in
                    demo.wireframe.settings.edgeColor.x = newValue
                }
            }
            HStack {
                Text("Green")
                    .frame(width: SettingsDemoControls.labelWidth, alignment: .trailing)

                Slider(value: $green, in: 0...1) {
                    Text("")
                }
                .onAppear {
                    green = demo.wireframe.settings.edgeColor.y
                }
                .onChange(of: green) { newValue in
                    demo.wireframe.settings.edgeColor.y = newValue
                }
            }

            HStack {
                Text("Blue")
                    .frame(width: SettingsDemoControls.labelWidth, alignment: .trailing)

                Slider(value: $blue, in: 0...1) {
                    Text("")
                }
                .onAppear {
                    blue = demo.wireframe.settings.edgeColor.z
                }
                .onChange(of: blue) { newValue in
                    demo.wireframe.settings.edgeColor.z = newValue
                }
            }

            HStack {
                Text("Alpha")
                    .frame(minWidth: SettingsDemoControls.labelWidth, alignment: .trailing)

                Slider(value: $alpha, in: 0...1) {
                    Text("")
                }
                .onAppear {
                    alpha = demo.wireframe.settings.edgeColor.w
                }
                .onChange(of: alpha) { newValue in
                    demo.wireframe.settings.edgeColor.w = newValue
                }
            }
        }
    }
}

struct BackgroundColorControls: View {

    @ObservedObject var demo: SettingsDemo

    var body: some View {
        VStack(alignment: .leading) {

            HStack {
                Text("Red")
                    .frame(width: SettingsDemoControls.labelWidth, alignment: .trailing)

                Slider(value: $demo.renderController.backgroundColor.x, in: 0...1) {
                    Text("")
                }
            }

            HStack {
                Text("Green")
                    .frame(width: SettingsDemoControls.labelWidth, alignment: .trailing)

                Slider(value: $demo.renderController.backgroundColor.y, in: 0...1) {
                    Text("")
                }
            }

            HStack {
                Text("Blue")
                    .frame(width: SettingsDemoControls.labelWidth, alignment: .trailing)

                Slider(value: $demo.renderController.backgroundColor.z, in: 0...1) {
                    Text("")
                }
            }

            HStack {
                Text("Alpha")
                    .frame(minWidth: SettingsDemoControls.labelWidth, alignment: .trailing)

                Slider(value: $demo.renderController.backgroundColor.w, in: 0...1) {
                    Text("")
                }
            }
        }
    }
}

struct ProjectionControls: View {

    @ObservedObject var demo: SettingsDemo

    @State var yFOV: Float = 0

    @State var zNear: Float = 0

    @State var zFar: Float = 0

    var yFOVMin: Float = 0.01
    var yFOVMax: Float = 0.99 * Float.pi

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("zNear")
                    .frame(width: SettingsDemoControls.labelWidth, alignment: .trailing)
                Slider(value: $zNear, in: 0.01...99.99) {
                    Text("")
                } onEditingChanged: { editing in
                    if !editing {
                        demo.fovController.zNear = zNear
                    }
                }
                .onAppear {
                    zNear = demo.fovController.zNear
                }
            }

            HStack {
                Text("zFar")
                    .frame(width: SettingsDemoControls.labelWidth, alignment: .trailing)
                Slider(value: $zFar, in: 100...1000) {
                    Text("")
                } onEditingChanged: { editing in
                    if !editing {
                        demo.fovController.zFar = zFar
                    }
                }
                .onAppear {
                    zFar = demo.fovController.zFar
                }
            }

            HStack {
                Text("yFOV")
                    .frame(width: SettingsDemoControls.labelWidth, alignment: .trailing)
                Slider(value: $yFOV, in: yFOVMin...yFOVMax) {
                    Text("")
                } onEditingChanged: { editing in
                    if !editing {
                        demo.fovController.yFOV = yFOV
                    }
                }
                .onAppear {
                    yFOV = demo.fovController.yFOV
                }
            }
        }
    }
}
