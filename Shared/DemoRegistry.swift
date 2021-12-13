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
    case wireframe = "Wireframe Settings"
}

class DemoRegistry: ObservableObject {

    var ball = BallDemo()

    var cube = CubeDemo()

    var wireframe = WireframeDemo()

    func controlsView(_ demo: DemoType) -> some View {
        Group {
            switch demo {
//            case .ball:
//                BallSettingsView(ball)
            case .cube:
                CubeDemoControls(demo: cube)
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
            case .cube:
                CubeDemoFigure(demo: cube)
            case .wireframe:
                WireframeDemoFigure(demo: wireframe)
            default:
                Text(demo.rawValue)
            }
        }
    }
}
