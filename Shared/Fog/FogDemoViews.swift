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

    var onsetSliderRange: ClosedRange<Float> {
        return 0...(0.999 * fog.visibilityLimitMax)
    }

    var limitSliderRange: ClosedRange<Float> {
        return fog.rendererSettings.fadeoutOnset...fog.visibilityLimitMax
    }

    var body: some View {

        VStack(alignment: .leading) {
            VStack {
                HStack {
                    Text("Fadeout Onset")
                    TextField("", value: $fog.rendererSettings.fadeoutOnset, formatter: zFormatter)
                }
                .settingControl()

                Slider(value: $fog.rendererSettings.fadeoutOnset, in: onsetSliderRange)
                    .settingControl()

                Spacer().frame(height: 10)

                HStack {
                    Text("Visibility Limit")
                    TextField("", value: $fog.rendererSettings.visibilityLimit, formatter: zFormatter)
                }
                .settingControl()

                Slider(value: $fog.rendererSettings.visibilityLimit, in: limitSliderRange)
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
