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

    lazy var monochrome = MonochromeDemo()

    lazy var coloredNodes = ColoredNodesDemo()

    func info(_ demo: DemoType) -> String {
        switch demo {
        case .ball:
            return ball.info
        case .cube:
            return cube.info
        case .picking:
            return picking.info
        case .monochrome:
            return monochrome.info
        case .coloredNodes:
            return coloredNodes.info
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
            case .monochrome:
                monochrome.controlsView
            case .coloredNodes:
                coloredNodes.controlsView
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
            case .monochrome:
                monochrome.figureView
            case .coloredNodes:
                coloredNodes.figureView
            }
        }
    }
}
