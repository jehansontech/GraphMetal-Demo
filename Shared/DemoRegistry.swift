//
//  DemoRegistry.swift
//  GraphMetal-Demo
//
//  Created by Jim Hanson on 11/29/21.
//

import SwiftUI

class DemoRegistry: ObservableObject {

    lazy var ball = BallDemo()

    lazy var cube = CubeDemo()

    lazy var picking = PickingDemo()

    lazy var appearance = SettingsDemo()

    func info(_ demo: DemoType) -> String {
        switch demo {
        case .ball:
            return ball.info
        case .cube:
            return cube.info
        case .picking:
            return picking.info
        case .appearance:
            return appearance.info
        }

    }

    func controlsView(_ demo: DemoType) -> some View {
        Group {
            switch demo {
            case .ball:
                BallDemoControls(demo: ball)
            case .cube:
                CubeDemoControls(demo: cube)
            case .picking:
                PickingDemoControls(demo: picking)
            case .appearance:
                SettingsDemoControls(demo: appearance)
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
            case .picking:
                PickingDemoFigure(demo: picking)
            case .appearance:
                SettingsDemoFigure(demo: appearance)
            }
        }
    }
}
