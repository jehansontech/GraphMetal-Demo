//
//  DemoRegistry.swift
//  GraphMetal-Demo
//
//  Created by Jim Hanson on 11/29/21.
//

import SwiftUI

enum DemoType: String, CaseIterable {
    case wireframe = "Wireframe Settings"
    case cube = "Cube"
    case ball = "Ball"
    case fog = "Fog"
}

class DemoRegistry: ObservableObject {

    var ball = BallDemo()

    var cube = CubeDemo()

    var fog = FogDemo()

    var wireframe = WireframeDemo()

    func controlsView(_ demo: DemoType) -> some View {
        Group {
            switch demo {
//            case .ball:
//                BallSettingsView(ball)
//            case .cube:
//                CubeSettingsView(cube)
//            case .fog:
//                FogSettingsView(fog)
            case .wireframe:
                WireframeDemoControls(demo: wireframe)
            default:
                Text(demo.rawValue)
            }
        }
    }

    func figureView(_ demo: DemoType) -> some View {
        Group {
            switch demo {
//            case .ball:
//                BallDisplayView(ball)
//            case .cube:
//                CubeDisplayView(cube)
//            case .fog:
//                FogDisplayView(fog)
            case .wireframe:
                WireframeDemoFigure(demo: wireframe)
            default:
                Text(demo.rawValue)
            }
        }
    }
}
