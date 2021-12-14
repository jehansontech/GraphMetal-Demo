//
//  BallDemoFigure.swift
//  GraphMetal-Demo
//
//  Created by Jim Hanson on 12/13/21.
//

import SwiftUI
import GraphMetal

struct BallDemoFigure: View {

    @ObservedObject var demo: BallDemo

    var body: some View {
        GraphView(demo,
                  povController: demo.povController,
                  wireframeSettings: demo.wireframeSettings)
            .onDisappear {
                demo.growing = false
            }
    }
}
