//
//  DimmingDemoView.swift
//  GraphMetal-Demo
//
//  Created by Jim Hanson on 11/29/21.
//

import SwiftUI
import GraphMetal

struct DimmingDemoView: View {

    @ObservedObject var demo: DimmingDemo

    var body: some View {
        NavigationView {
            DimmingSettingsView(demo)
            GraphView($demo.rendererSettings,
                      demo,
                      demo.povController)
        }
        .onAppear {
            demo.setup()
        }
        .onDisappear {
            demo.teardown()
        }
    }

    init(_ demo: DimmingDemo) {
        self.demo = demo
    }
}

struct DimmingSettingsView: View {

    @ObservedObject var demo: DimmingDemo

    let indent: CGFloat = 20

    let zFormatter: NumberFormatter

    var body: some View {

        VStack {
            Text("Visibility")
            HStack {
                Spacer().frame(width: indent)
                VStack {
                    TextField("", value: $demo.rendererSettings.zFar, formatter: zFormatter)
                    Slider(value: $demo.rendererSettings.zFar, in: 1...10000)
                }
            }
        }

    }

    init(_ demo: DimmingDemo) {
        self.demo = demo
        self.zFormatter = NumberFormatter()
        zFormatter.numberStyle = .decimal
        zFormatter.maximumSignificantDigits = 3
    }
}
