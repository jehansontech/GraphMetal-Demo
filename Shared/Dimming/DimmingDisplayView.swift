//
//  DimmingDisplayView.swift
//  GraphMetal-Demo
//
//  Created by Jim Hanson on 11/23/21.
//

import SwiftUI
import GraphMetal

struct DimmingDisplayView: View {

    @ObservedObject var demo: DimmingDemo

    var body: some View {
        GraphView($demo.rendererSettings, demo, demo.povController)
            .navigationTitle("\(demo.name)")
        // .navigationBarTitleDisplayMode(.inline)
    }

    init(_ demo: DimmingDemo) {
        self.demo = demo
    }
}
