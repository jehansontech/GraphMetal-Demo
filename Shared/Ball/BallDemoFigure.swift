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
            RendererView(viewModel.renderer,
                         GestureHandlers(primaryDrag: viewModel.renderer,
                                         pinch: viewModel.renderer,
                                         rotation: viewModel.renderer))
            .onDisappear {
                viewModel.stop()
            }
            ZOverlay(viewModel.renderer)
        }
        .onChange(of: colorScheme) { newValue in
            viewModel.setColorScheme(newValue)
        }
    }

    init(_ viewModel: BallDemoViewModel) {
        self.viewModel = viewModel
    }
}
