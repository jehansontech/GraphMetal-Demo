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
        return 0...1000
    }

    var distanceSliderRange: ClosedRange<Float> {
        return 0...1000
    }

    var body: some View {

        VStack(alignment: .leading) {
            VStack {
                HStack {
                    Text("Fadeout Onset")
                    TextField("", value: $fog.renderController.fadeoutOnset, formatter: zFormatter)
                }
                .settingControl()

                Slider(value: $fog.renderController.fadeoutOnset, in: onsetSliderRange)
                    .settingControl()

                Spacer().frame(height: 10)

                HStack {
                    Text("Fadeout Distance")
                    TextField("", value: $fog.renderController.fadeoutDistance, formatter: zFormatter)
                }
                .settingControl()

                Slider(value: $fog.renderController.fadeoutDistance, in: distanceSliderRange)
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
        GraphView(fog,
                  renderController: fog.renderController,
                  povController: fog.povController)
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
