//
//  DemoRegistry.swift
//  GraphMetal-Demo
//
//  Created by Jim Hanson on 11/29/21.
//

import SwiftUI

@MainActor
class DemoRegistry: ObservableObject {

    lazy var ball = BallDemo()

    lazy var cube = CubeDemo()

    lazy var picking = PickingDemo()

    lazy var appearance = SettingsDemo()

    lazy var wireframe2 = ColoredNodesDemo()

    lazy var monochromeSettings = MonochromeDemo()

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
        case .coloredNodes:
            return wireframe2.info
        case .monochrome:
            return monochromeSettings.info
        }

    }

    @MainActor
    func controlsView(_ demo: DemoType) -> some View {
        Group {
            switch demo {
            case .ball:
                ball.controlsView
            case .cube:
                cube.controlsView
            case .picking:
                picking.controlsView
            case .appearance:
                appearance.controlsView
            case .coloredNodes:
                wireframe2.controlsView
            case .monochrome:
                monochromeSettings.controlsView
            }
        }
    }

    @MainActor
    func figureView(_ demo: DemoType) -> some View {
        Group {
            switch demo {
            case .ball:
                ball.figureView
            case .cube:
                cube.figureView
            case .picking:
                picking.figureView
            case .appearance:
                appearance.figureView
            case .coloredNodes:
                wireframe2.figureView
            case .monochrome:
                monochromeSettings.figureView
            }
        }
    }
}
