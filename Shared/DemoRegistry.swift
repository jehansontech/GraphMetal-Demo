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

    lazy var ball = BallDemo()

    lazy var cube = CubeDemo()

    lazy var wireframe = WireframeDemo()

    func controlsView(_ demo: DemoType) -> some View {
        Group {
            switch demo {
            case .ball:
                BallDemoControls(demo: ball)
            case .cube:
                CubeDemoControls(demo: cube)
            case .wireframe:
                WireframeDemoControls(demo: wireframe)
            }
        }
    }

    func figureView(_ demo: DemoType) -> some View {
        Group {
            switch demo {
            case .ball:
                BallDemoFigure(demo: ball)
            case .cube:
                CubeDemoFigure(demo: cube)
            case .wireframe:
                WireframeDemoFigure(demo: wireframe)
            }
        }
    }
}
