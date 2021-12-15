//
//  DemoRegistry.swift
//  GraphMetal-Demo
//
//  Created by Jim Hanson on 11/29/21.
//

import SwiftUI

class DemoRegistry: ObservableObject {

    lazy var motion = MotionDemo()
    
    lazy var ball = BallDemo()

    lazy var cube = CubeDemo()

    lazy var appearance = AppearanceDemo()

    func info(_ demo: DemoType) -> String {
        switch demo {
        case .motion:
            return motion.info
        case .ball:
            return ball.info
        case .cube:
            return cube.info
        case .appearance:
            return appearance.info
        }

    }

    func controlsView(_ demo: DemoType) -> some View {
        Group {
            switch demo {
            case .motion:
                MotionDemoControls(demo: motion)
            case .ball:
                BallDemoControls(demo: ball)
            case .cube:
                CubeDemoControls(demo: cube)
            case .appearance:
                AppearanceDemoControls(demo: appearance)
            }
        }
    }

    func figureView(_ demo: DemoType) -> some View {
        Group {
            switch demo {
            case .motion:
                MotionDemoFigure(demo: motion)
            case .ball:
                BallDemoFigure(demo: ball)
            case .cube:
                CubeDemoFigure(demo: cube)
            case .appearance:
                AppearanceDemoFigure(demo: appearance)
            }
        }
    }
}
