//
//  Wireframe2DemoRunner.swift
//  GraphMetal-Demo
//
//  Created by Jim Hanson on 7/12/24.
//

import Foundation
import Wacoma
import GenericGraph
import GraphMetal

actor Wireframe2DemoRunner {

    private var viewModel: Wireframe2DemoViewModel!

    private var graph: Wireframe2DemoGraph

    init() {
        self.graph = Wireframe2DemoGraph()
    }

    func finishConnecting(_ viewModel: Wireframe2DemoViewModel) async {
        print("Wireframe2DemoRunner.finishConnecting: entered")
        self.viewModel = viewModel
        print("Wireframe2DemoRunner.finishConnecting: exiting")
    }
}
