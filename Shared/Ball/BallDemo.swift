//
//  BallDemo.swift
//  GraphMetal-Demo
//
//  Created by Jim Hanson on 5/10/21.
//

import SwiftUI

class BallDemo: Demo {

    var type: DemoType { return .ball }

    var info: String { return "Shows a graph that changes over time" }

    @MainActor
    private lazy var viewModel = BallDemoViewModel()

    @MainActor
    var controlsView: BallDemoControls {
        BallDemoControls(viewModel)
    }

    @MainActor
    var figureView: BallDemoFigure {
        BallDemoFigure(viewModel)
    }
}

