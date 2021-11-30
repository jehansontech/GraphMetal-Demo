//
//  VisibilityDemoViews.swift
//  GraphMetal-Demo
//
//  Created by Jim Hanson on 11/29/21.
//

import SwiftUI
import GraphMetal

struct FogSettingsView: View {

    @ObservedObject var fog: FogDemo

    @State var visibilityExpanded = true

    let zFormatter: NumberFormatter

    var body: some View {

        VStack(alignment: .leading) {
            DisclosureGroup("Visibility", isExpanded: $visibilityExpanded) {
                VStack {
                Slider(value: $fog.rendererSettings.zFar, in: 1...1000)
                TextField("", value: $fog.rendererSettings.zFar, formatter: zFormatter)
                }
                .settingControl()
            }

            Spacer()
        }
    }

    init(_ fog: FogDemo) {
        self.fog = fog
        self.zFormatter = NumberFormatter()
        zFormatter.numberStyle = .decimal
        zFormatter.maximumSignificantDigits = 3
    }
}

struct FogDisplayView: View {

    @ObservedObject var fog: FogDemo

    var body: some View {
        GraphView($fog.rendererSettings,
                  fog,
                  fog.povController)
            .onAppear {
                fog.setup()
            }
            .onDisappear {
                fog.teardown()
            }
    }

    init(_ fog: FogDemo) {
        self.fog = fog
    }
}
