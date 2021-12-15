//
//  VisibilityDemoViews.swift
//  GraphMetal-Demo
//
//  Created by Jim Hanson on 11/29/21.
//

import SwiftUI
import GraphMetal

struct CubeDemoControls: View {
    
    static var labelWidth: CGFloat = 80
    
    @ObservedObject var demo: CubeDemo
    
    var body: some View {
        if demo.needsPresentation {
            Button {
                withAnimation {
                    demo.present()
                }
            } label: {
                Text("CLICK ME")
                    .font(.headline.smallCaps())
            }
        }
        else {
            VStack(alignment: .leading, spacing: 10) {
                Text("Rotation")
                OrbitControls(demo: demo)
                    .padding(.leading, 10)
                    .frame(maxWidth: .infinity)
                Text("Fadeout")
                FadeoutControls(demo: demo)
                    .padding(.leading, 10)
                    .frame(maxWidth: .infinity)
                Text("Moving around")
                POVControllerUsage(demo: demo)
                    .padding(.leading, 10)
                    .frame(maxWidth: .infinity)
            }
        }
    }
}

struct FadeoutControls: View {
    
    @ObservedObject var demo: CubeDemo
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Onset")
                    .frame(width: CubeDemoControls.labelWidth, alignment: .trailing)
                Slider(value: $demo.renderController.fadeoutOnset, in: 1...100)
            }
            HStack {
                Text("Distance")
                    .frame(width: CubeDemoControls.labelWidth, alignment: .trailing)
                Slider(value: $demo.renderController.fadeoutDistance, in: 1...100)
            }
        }
    }
}

struct OrbitControls: View {
    
    @ObservedObject var demo: CubeDemo
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Enabled")
                    .frame(width: CubeDemoControls.labelWidth, alignment: .trailing)
                Toggle("", isOn: $demo.povController.orbitEnabled)
                    .toggleStyle(.switch)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            HStack {
                Text("Speed")
                    .frame(width: CubeDemoControls.labelWidth, alignment: .trailing)
                Slider(value: $demo.povController.orbitSpeed, in: -1...1)
            }
        }
    }
}

struct POVControllerUsage: View {
    
    let hint = "Use gestures to change your point of view"
    
    var gestureHints: [(String, String)] = [
        ("Drag", "Appears to rotate the figure in the direction you drag"),
        ("Pinch", "Zooms in or out"),
        ("Rotate", "Rotates the POV in the plane of the screen")
    ]
    
    
    @ObservedObject var demo: CubeDemo
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            
            Text(hint)
            
            ForEach(gestureHints.indices, id: \.self) { idx in
                HStack(alignment: .top, spacing: 10) {
                    Text(gestureHints[idx].0)
                        .font(.body.smallCaps())
                        .frame(width: CubeDemoControls.labelWidth, alignment: .trailing)
                    Text(gestureHints[idx].1)
                }
            }
            
            HStack {
                Button {
                    demo.povController.goToDefaultPOV()
                } label: {
                    Text("Reset POV")
                }
            }
            .padding(.top, 10)
            .frame(maxWidth: .infinity)
            
        }
    }
}
