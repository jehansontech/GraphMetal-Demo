//
//  VisibilityDemoViews.swift
//  GraphMetal-Demo
//
//  Created by Jim Hanson on 11/29/21.
//

import SwiftUI
import GraphMetal

struct CubeDemoControls: View {

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
                    .frame(width: demo.labelWidth, alignment: .trailing)
                Slider(value: $demo.renderController.fadeoutOnset, in: 1...100)
            }
            HStack {
                Text("Distance")
                    .frame(width: demo.labelWidth, alignment: .trailing)
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
                    .frame(width: demo.labelWidth, alignment: .trailing)
                Toggle("", isOn: $demo.povController.orbitEnabled)
                    .toggleStyle(.switch)
                    .frame(maxWidth: .infinity)
            }
            HStack {
                Text("Speed")
                    .frame(width: demo.labelWidth, alignment: .trailing)
                Slider(value: $demo.povController.orbitSpeed, in: -1...1)
            }
        }
    }
}

struct POVControllerUsage: View {

    @ObservedObject var demo: CubeDemo

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            ForEach(demo.povControllerUsage.indices, id: \.self) { idx in
                HStack(alignment: .top) {
                    Text(demo.povControllerUsage[idx].0)
                        .font(.body.smallCaps())
                        .frame(width: demo.labelWidth, alignment: .trailing)
                    Text(demo.povControllerUsage[idx].1)
                }
            }
        }
    }
}
