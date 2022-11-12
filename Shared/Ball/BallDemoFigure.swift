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

    @Environment(\.colorScheme) private var colorScheme

    @ObservedObject var viewModel: BallDemoViewModel

    var body: some View {
        ZStack {
            RendererView(viewModel.renderController,
                         GestureHandlers(dragHandler: viewModel.povController,
                                         pinchHandler: viewModel.renderController,
                                         rotationHandler: viewModel.renderController))
            .onDisappear {
                viewModel.stop()
            }
            Overlay(viewModel.renderController)
        }
        .onChange(of: colorScheme) { newValue in
            viewModel.setColorScheme(newValue)
        }
    }

    init(_ viewModel: BallDemoViewModel) {
        self.viewModel = viewModel
    }
}
