//
//  CubeDemoControls.swift
//  GraphMetal-Demo
//
//  Created by Jim Hanson on 11/29/21.
//

import SwiftUI
import GraphMetal
import Wacoma

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
                Text("Click me")
                    .font(.headline.smallCaps())
            }
        }
        else {
            VStack(alignment: .leading, spacing: 10) {
                Text("Orbit")
                    .font(.headline.smallCaps())
                OrbitControls(povController: demo.povController)
                    .padding(.leading, 10)
                    .frame(maxWidth: .infinity)

                Divider()

                Text("Fadeout")
                    .font(.headline.smallCaps())
                FadeoutControls(fovController: demo.fovController)
                    .padding(.leading, 10)
                    .frame(maxWidth: .infinity)

                Divider()

                Text("Changing the point of view")
                    .font(.headline.smallCaps())
                POVControllerUsage(demo: demo)
                    .padding(.leading, 10)
                    .frame(maxWidth: .infinity)
            }
        }
    }
}

struct OrbitControls: View {

    @ObservedObject var povController: OrbitingPOVController

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Enabled")
                    .frame(width: CubeDemoControls.labelWidth, alignment: .trailing)
                Toggle("", isOn: $povController.orbitEnabled)
                    .toggleStyle(.switch)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            HStack {
                Text("Speed")
                    .frame(width: CubeDemoControls.labelWidth, alignment: .trailing)
                Slider(value: $povController.orbitSpeed, in: -1...1)
            }
        }
    }
}

struct FadeoutControls: View {

    @ObservedObject var fovController: PerspectiveFOVController

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Midpoint")
                    .frame(width: CubeDemoControls.labelWidth, alignment: .trailing)
                Slider(value: $fovController.fadeoutMidpoint, in: 1...100)
            }
            HStack {
                Text("Distance")
                    .frame(width: CubeDemoControls.labelWidth, alignment: .trailing)
                Slider(value: $fovController.fadeoutDistance, in: 1...100)
            }
        }
    }
}

struct POVControllerUsage: View {

    var blurb = "Use gestures to move around"

    var gestureHints: [(String, String)] = [
        ("Drag", "Turns the figure"),
        ("Pinch", "Moves in or out"),
        ("Rotate", "Rolls the POV")
    ]

    @ObservedObject var demo: CubeDemo

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(blurb)

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
                    demo.povController.flyToDefault()
                } label: {
                    Text("Reset POV")
                }
            }
            .padding(.top, 10)
            .frame(maxWidth: .infinity)

        }
    }

    init(demo: CubeDemo) {
        self.demo = demo
    }
}

