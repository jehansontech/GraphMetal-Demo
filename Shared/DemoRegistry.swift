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
    case wireframe = "Appearance"
}

protocol Demo: AnyObject {

    var type: DemoType { get }

    var info: String { get }
}

class DemoRegistry: ObservableObject {

    lazy var ball = BallDemo()

    lazy var cube = CubeDemo()

    lazy var wireframe = AppearanceDemo()

    func controlsView(_ demo: DemoType) -> some View {
        Group {
            switch demo {
            case .ball:
                BallDemoControls(demo: ball)
            case .cube:
                CubeDemoControls(demo: cube)
            case .wireframe:
                AppearanceDemoControls(demo: wireframe)
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
                AppearanceDemoFigure(demo: wireframe)
            }
        }
    }
}
