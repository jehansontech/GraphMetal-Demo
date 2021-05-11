//
//  CubeDisplayView.swift
//  GraphMetal-Demo
//
//  Created by Jim Hanson on 4/27/21.
//

import SwiftUI
import UIStuffForSwift
import GraphMetal
import Combine

struct CubeDisplayView: View {

    @ObservedObject var cube: CubeDemo

    var body: some View {
        RendererView($cube.renderSettings, cube.graphController, cube.povController)
            .navigationTitle("\(cube.name)")
            .navigationBarTitleDisplayMode(.inline)
    }

    init(_ cube: CubeDemo) {
        self.cube = cube
    }
}