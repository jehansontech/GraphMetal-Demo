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

    @ObservedObject var demo: SettingsDemo

    @State var nodeSizeIsAdjusted: Bool = true

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
                Slider(value: $demo.wireframe.settings.nodeSizeMinimum, in: 1...200) {
                    Text("")
                }
            }

            HStack {
                Text("Maximum")
                    .frame(width: SettingsDemoControls.labelWidth, alignment: .trailing)
                Slider(value: $demo.wireframe.settings.nodeSizeMaximum, in: 1...200) {
                    Text("")
                }
            }

            HStack {
                Text(sizeScaleButtonText)
                    .frame(width: SettingsDemoControls.labelWidth, alignment: .trailing)
                Slider(value: $demo.wireframe.settings.nodeSize, in: 1...200) {
                    Text("")
                }
            }
        }
    }
}

struct NodeColorDefaultControls: View {

    @ObservedObject var demo: SettingsDemo

    @State var nodeColorDefault: SIMD4<Float> = .zero

    var body: some View {
        VStack(alignment: .leading) {

            Text("Node color default is used when a node's own color is not set (as in this case)")
                .padding(.bottom, 10)

            HStack {
                Text("Red")
                    .frame(width: SettingsDemoControls.labelWidth, alignment: .trailing)
                Slider(value: $nodeColorDefault.x, in: 0...1) {
                    Text("")
                }
            }

            HStack {
                Text("Green")
                    .frame(width: SettingsDemoControls.labelWidth, alignment: .trailing)
                Slider(value: $nodeColorDefault.y, in: 0...1) {
                    Text("")
                }
            }

            HStack {
                Text("Blue")
                    .frame(width: SettingsDemoControls.labelWidth, alignment: .trailing)
                Slider(value: $nodeColorDefault.z, in: 0...1) {
                    Text("")
                }
            }

            HStack {
                Text("Alpha")
                    .frame(width: SettingsDemoControls.labelWidth, alignment: .trailing)
                Slider(value: $nodeColorDefault.w, in: 0...1) {
                    Text("")
                }
            }
        }
        .onAppear {
            self.nodeColorDefault = demo.wireframe.settings.nodeColorDefault
        }
        .onChange(of: self.nodeColorDefault) { newValue in
            demo.wireframe.settings.nodeColorDefault = newValue
            demo.updateGraph(.nodeColors)
        }
    }
}

struct EdgeColorControls: View {

    @ObservedObject var demo: SettingsDemo

    var body: some View {
        VStack(alignment: .leading) {

            Text("All edges have the same color")
                .padding(.bottom, 10)

            HStack {
                Text("Red")
                    .frame(width: SettingsDemoControls.labelWidth, alignment: .trailing)
                Slider(value: $demo.wireframe.settings.edgeColor.x, in: 0...1) {
                    Text("")
                }
            }

            HStack {
                Text("Green")
                    .frame(width: SettingsDemoControls.labelWidth, alignment: .trailing)
                Slider(value: $demo.wireframe.settings.edgeColor.y, in: 0...1) {
                    Text("")
                }
            }

            HStack {
                Text("Blue")
                    .frame(width: SettingsDemoControls.labelWidth, alignment: .trailing)
                Slider(value: $demo.wireframe.settings.edgeColor.z, in: 0...1) {
                    Text("")
                }
            }

            HStack {
                Text("Alpha")
                    .frame(minWidth: SettingsDemoControls.labelWidth, alignment: .trailing)
                Slider(value: $demo.wireframe.settings.edgeColor.w, in: 0...1) {
                    Text("")
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

    let yFOVMin: Float = 0.01 * Float.pi
    let yFOVMax: Float = 0.99 * Float.pi

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("zNear")
                    .frame(width: SettingsDemoControls.labelWidth, alignment: .trailing)
                Slider(value: $demo.fovController.zNear, in: 0.01...9.99) {
                    Text("")
                }
            }

            HStack {
                Text("zFar")
                    .frame(width: SettingsDemoControls.labelWidth, alignment: .trailing)
                Slider(value: $demo.fovController.zFar, in: 10...100) {
                    Text("")
                }
            }

            HStack {
                Text("yFOV")
                    .frame(width: SettingsDemoControls.labelWidth, alignment: .trailing)
                Slider(value: $demo.fovController.yFOV, in: yFOVMin...yFOVMax) {
                    Text("")
                }
            }
        }
    }
}
