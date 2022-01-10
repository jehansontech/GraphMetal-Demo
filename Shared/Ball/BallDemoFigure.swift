//
//  BallDemoFigure.swift
//  GraphMetal-Demo
//
//  Created by Jim Hanson on 12/13/21.
//

import SwiftUI
import GraphMetal
import Wacoma

struct BallDemoFigure: View {

    @ObservedObject var demo: BallDemo

    var body: some View {
        ZStack {
            RendererView(demo.renderController,
                         GestureHandlers(dragHandler: demo.povController,
                                         pinchHandler: demo.povController,
                                         rotationHandler: demo.povController))
                .onDisappear {
                    demo.growing = false
                }
            Overlay(demo.renderController)
        }
    }
}
