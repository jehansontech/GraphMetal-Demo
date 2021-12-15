//
//  AppearanceDemoControls.swift
//  GraphMetal-Demo
//
//  Created by Jim Hanson on 12/13/21.
//

import SwiftUI
import Wacoma

struct AppearanceDemoControls: View {
    
    static var labelWidth: CGFloat = 90
    
    @ObservedObject var demo: AppearanceDemo
    
    @State var nodeSizeIsExpanded = false
    
    @State var nodeColorDefaultIsExpanded = false
    
    @State var edgeColorIsExpanded = false
    
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
                        projectionIsExpanded = false
                    }
                    .padding(.leading, 2)
                }
                
                //                DisclosureGroup("Field of view", isExpanded: $projectionIsExpanded) {
                //                    HStack {
                //                        Divider()
                //                        ProjectionControls(demo: demo)
                //                    }
                //                    .onAppear {
                //                        nodeSizeIsExpanded = false
                //                        edgeColorIsExpanded = false
                //                        nodeColorDefaultIsExpanded = false
                //                    }
                //                    .padding(.leading, 2)
                //                }
                
                //                HStack {
                //                    Button {
                //                        nodeSizeIsExpanded = false
                //                        nodeColorDefaultIsExpanded = false
                //                        edgeColorIsExpanded = false
                //                        demo.wireframeSettings.reset()
                //                        demo.renderController.resetFOV()
                //                    } label: {
                //                        Text("Reset all")
                //                    }
                //                }
                //                .padding(.top, 5)
                //                .frame(maxWidth: .infinity)
            }
        }
    }
}


struct NodeSizeControls: View {
    
    var demo: AppearanceDemo
    
    @State var isAdjustedText: String = ""
    
    @State var nodeSizeDefault: Double = 1
    
    @State var nodeSizeMinimum: Double = 1
    
    @State var nodeSizeMaximum: Double = 1
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            
            Text("Node size can change automatically as you zoom in or out, or you can set it manually")
                .padding(.bottom, 10)

            HStack {
                Text("Automatic")
                    .frame(width: AppearanceDemoControls.labelWidth, alignment: .trailing)
                
                Button {
                    demo.wireframeSettings.nodeSizeIsAdjusted.toggle()
                    updateIsAdjustedText()
                } label: {
                    Text(isAdjustedText)
                }
                .onAppear {
                    updateIsAdjustedText()
                }
                .frame(maxWidth: .infinity, alignment: .center)
            }
            
            HStack {
                Text("Minimum")
                    .frame(width: AppearanceDemoControls.labelWidth, alignment: .trailing)
                
                Slider(value: $nodeSizeMinimum, in: 1...200) {
                    Text("")
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
                    .frame(width: AppearanceDemoControls.labelWidth, alignment: .trailing)
                
                Slider(value: $nodeSizeMaximum, in: 1...200) {
                    Text("")
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
            
            HStack {
                Text("Manual")
                    .frame(width: AppearanceDemoControls.labelWidth, alignment: .trailing)
                
                Slider(value: $nodeSizeDefault, in: 1...200) {
                    Text("")
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
    
    var demo: AppearanceDemo
    
    @State var red: Float = 0
    @State var green: Float = 0
    @State var blue: Float = 0
    @State var alpha: Float = 1
    
    var body: some View {
        VStack(alignment: .leading) {
            
            Text("Node default color is used when a node's own color is not set")
                .padding(.bottom, 10)

            HStack {
                Text("Red")
                    .frame(width: AppearanceDemoControls.labelWidth, alignment: .trailing)
                
                Slider(value: $red, in: 0...1) {
                    Text("")
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
                    .frame(width: AppearanceDemoControls.labelWidth, alignment: .trailing)
                
                Slider(value: $green, in: 0...1) {
                    Text("")
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
                    .frame(width: AppearanceDemoControls.labelWidth, alignment: .trailing)
                
                Slider(value: $blue, in: 0...1) {
                    Text("")
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
                    .frame(width: AppearanceDemoControls.labelWidth, alignment: .trailing)
                
                Slider(value: $alpha, in: 0...1) {
                    Text("")
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
    
    var demo: AppearanceDemo
    
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
                    .frame(width: AppearanceDemoControls.labelWidth, alignment: .trailing)
                
                Slider(value: $red, in: 0...1) {
                    Text("")
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
                    .frame(width: AppearanceDemoControls.labelWidth, alignment: .trailing)
                
                Slider(value: $green, in: 0...1) {
                    Text("")
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
                    .frame(width: AppearanceDemoControls.labelWidth, alignment: .trailing)
                
                Slider(value: $blue, in: 0...1) {
                    Text("")
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
                    .frame(minWidth: AppearanceDemoControls.labelWidth, alignment: .trailing)
                
                Slider(value: $alpha, in: 0...1) {
                    Text("")
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

struct ProjectionControls: View {
    
    @ObservedObject var demo: AppearanceDemo
    
    @State var yFOV: Float = 0
    
    @State var zNear: Float = 0
    
    @State var zFar: Float = 0
    
    var yFOVMin: Float = 0.01
    var yFOVMax: Float = 0.01 * floor(99 * Float.twoPi)
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("zNear")
                    .frame(width: AppearanceDemoControls.labelWidth, alignment: .trailing)
                Slider(value: $zNear, in: 0.01...100) {
                    Text("")
                } minimumValueLabel: {
                    Text("0.01")
                } maximumValueLabel: {
                    Text("100")
                } onEditingChanged: { editing in
                    if !editing {
                        demo.renderController.zNear = zNear
                    }
                }
                .onAppear {
                    zNear = demo.renderController.zNear
                }
            }
            
            HStack {
                Text("zFar")
                    .frame(width: AppearanceDemoControls.labelWidth, alignment: .trailing)
                Slider(value: $zFar, in: 100...1000) {
                    Text("")
                } minimumValueLabel: {
                    Text("100")
                } maximumValueLabel: {
                    Text("1000")
                } onEditingChanged: { editing in
                    if !editing {
                        demo.renderController.zFar = zFar
                    }
                }
                .onAppear {
                    zFar = demo.renderController.zFar
                }
            }
            
            HStack {
                Text("yFOV")
                    .frame(width: AppearanceDemoControls.labelWidth, alignment: .trailing)
                Slider(value: $yFOV, in: yFOVMin...yFOVMax, step: 0.01) {
                    Text("")
                } minimumValueLabel: {
                    Text("\(yFOVMin)")
                } maximumValueLabel: {
                    Text("\(yFOVMax)")
                } onEditingChanged: { editing in
                    if !editing {
                        demo.renderController.yFOV = yFOV
                    }
                }
                .onAppear {
                    yFOV = demo.renderController.yFOV
                }
            }
        }
    }
}
