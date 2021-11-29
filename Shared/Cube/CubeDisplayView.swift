//
//  CubeDisplayView.swift
//  GraphMetal-Demo
//
//  Created by Jim Hanson on 4/27/21.
//

import SwiftUI
import GraphMetal
import Combine

struct CubeDisplayView: View {

    @ObservedObject var demo: CubeDemo

    var body: some View {
        GraphView($demo.rendererSettings, demo, demo.povController)
            .navigationTitle("\(demo.name)")
            // .navigationBarTitleDisplayMode(.inline)
    }

    init(_ cube: CubeDemo) {
        self.demo = cube
    }
}
