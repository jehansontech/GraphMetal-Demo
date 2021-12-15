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
                  renderController: demo.renderController,
                  povController: demo.povController)
            .onDisappear {
                demo.growing = false
            }
    }
}
