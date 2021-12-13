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
                    // demo.needsPresentation.toggle()
                }
            } label: {
                Text("CLICK ME")
                    .font(.headline.smallCaps())
            }
        }
        else {
            VStack(alignment: .leading, spacing: 10) {
                Text("Orbit")
                OrbitControls(demo: demo)
                    .padding(.leading, 10)
                    .frame(maxWidth: .infinity)
                Text("Fadeout")
                FadeoutControls(demo: demo)
                    .padding(.leading, 10)
                    .frame(maxWidth: .infinity)
            }
//            .onAppear {
//                demo.present()
//            }
        }
    }
}

struct FadeoutControls: View {
    
    @ObservedObject var demo: CubeDemo
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Onset")
                    .frame(width: AppearanceDemoControls.labelWidth, alignment: .trailing)
                Slider(value: $demo.renderController.fadeoutOnset, in: 1...100) {
                    Text("")
                } minimumValueLabel: {
                    Text("1")
                } maximumValueLabel: {
                    Text("100")
                }
            }
            HStack {
                Text("Distance")
                    .frame(width: AppearanceDemoControls.labelWidth, alignment: .trailing)
                Slider(value: $demo.renderController.fadeoutDistance, in: 1...100) {
                    Text("")
                } minimumValueLabel: {
                    Text("1")
                } maximumValueLabel: {
                    Text("100")
                }
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
                    .frame(width: AppearanceDemoControls.labelWidth, alignment: .trailing)
                Toggle("", isOn: $demo.povController.orbitEnabled)
                    .toggleStyle(.switch)
                    .frame(maxWidth: .infinity)
            }
            HStack {
                Text("Speed")
                    .frame(width: AppearanceDemoControls.labelWidth, alignment: .trailing)
                Slider(value: $demo.povController.orbitSpeed, in: -1...1) {
                    Text("")
                } minimumValueLabel: {
                    Text("-1")
                } maximumValueLabel: {
                    Text("+1")
                }
            }
            
        }
    }
}
