//
//  ScaleFreeDemo.swift
//  GraphMetal-Demo
//
//  Created by Jim Hanson on 4/27/21.
//

import SwiftUI

class ScaleFreeSettings: ObservableObject {

}

struct ScaleFreeDemo: Demo {

    let type: DemoType = .scaleFree

    var name: String

    var settings = ScaleFreeSettings()

    var settingsView: some View {
        ScaleFreeSettingsView(settings)
    }

    var displayView: some View {
        ScaleFreeDisplayView(settings)
    }

    init() {
        name = type.rawValue
    }

    func setup() {

    }

    func teardown() {

    }
}
