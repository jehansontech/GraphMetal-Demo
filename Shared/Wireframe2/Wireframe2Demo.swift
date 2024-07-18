//
//  Wireframe2Demo.swift
//  GraphMetal-Demo
//
//  Created by Jim Hanson on 7/12/24.
//

import SwiftUI

class Wireframe2Demo: Demo {

    var type: DemoType { return .wireframe2 }

    var info: String { return "Wireframe2 dev and test" }

    @MainActor
    private var viewModel: Wireframe2DemoViewModel = Wireframe2DemoViewModel()

    private var runner: Wireframe2DemoRunner = Wireframe2DemoRunner()

    @MainActor
    var controlsView: Wireframe2DemoControls {
        print("Wireframe2Demo.makeControlsView: entered")
        return Wireframe2DemoControls(viewModel)
    }

    @MainActor
    var figureView: Wireframe2DemoFigure {
        print("Wireframe2Demo.makeFigureView: entered")
        return Wireframe2DemoFigure(viewModel)
    }

    init() {
        print("Wireframe2Demo.init: entered")

        Task{
            print("Wireframe2Demo.init: connection task started")
            await viewModel.connect(runner)
            print("Wireframe2Demo.init: connection task finished")
        }

        print("Wireframe2Demo.init: exiting")
    }
}
