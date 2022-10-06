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
            }
        }
    }
}
