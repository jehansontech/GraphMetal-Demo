//
//  DemoRegistry.swift
//  GraphMetal-Demo
//
//  Created by Jim Hanson on 11/29/21.
//

import SwiftUI

enum DemoType: String, CaseIterable {
    case cube = "Cube"
    case ball = "Ball"
    case fog = "Fog"
}

class DemoRegistry: ObservableObject {

    var ball = BallDemo()

    var cube = CubeDemo()

    var fog = FogDemo()

    func settingsView(_ demo: DemoType) -> some View {
        Group {
            switch demo {
            case .ball:
                BallSettingsView(ball)
            case .cube:
                CubeSettingsView(cube)
            case .fog:
                FogSettingsView(fog)
            }
        }
    }

    func displayView(_ demo: DemoType) -> some View {
        Group {
            switch demo {
            case .ball:
                BallDisplayView(ball)
            case .cube:
                CubeDisplayView(cube)
            case .fog:
                FogDisplayView(fog)
            }
        }
    }
}
