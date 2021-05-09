//
//  ScaleFreeDemoSettingsView.swift
//  GraphMetal-Demo
//
//  Created by Jim Hanson on 4/27/21.
//

import SwiftUI

struct ScaleFreeSettingsView : View {

    @ObservedObject var settings: ScaleFreeSettings

    var body: some View {
        Text("ScaleFreeSettingsView")
    }

    init(_ settings: ScaleFreeSettings) {
        self.settings = settings
    }
}
