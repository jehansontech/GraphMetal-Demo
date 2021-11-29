//
//  DimmingSettingsView.swift
//  GraphMetal-Demo
//
//  Created by Jim Hanson on 11/23/21.
//

import Foundation

import SwiftUI
import Wacoma

struct DimmingSettingsView: View {

    let indent: CGFloat = 10

    let zFormatter: NumberFormatter

    @ObservedObject var demo: DimmingDemo

    // @State var group = SettingsGroup().itemStyle(.narrow)

    var body: some View {

        VStack {
            Text("zNear")
            HStack {
                Spacer().frame(width: indent)
                TextField("", value: $demo.rendererSettings.zNear, formatter: zFormatter)
            }
            Text("zFar")
            HStack {
                Spacer().frame(width: indent)
                TextField("", value: $demo.rendererSettings.zFar, formatter: zFormatter)
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
