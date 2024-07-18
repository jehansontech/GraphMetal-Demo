//
//  Wireframe2DemoFigure.swift
//  GraphMetal-Demo
//
//  Created by Jim Hanson on 7/12/24.
//

import SwiftUI
import GraphMetal
import Wacoma

struct Wireframe2DemoFigure: View {

    @Environment(\.colorScheme) private var colorScheme

    @ObservedObject var viewModel: Wireframe2DemoViewModel

    var body: some View {
        if !viewModel.isConnected {
            EmptyView()
        }
        else {
            ZStack {
                RendererView(viewModel.renderController,
                             GestureHandlers(primaryDrag: viewModel.renderController,
                                             pinch: viewModel.renderController,
                                             rotation: viewModel.renderController))
            }
            .onChange(of: colorScheme) { newValue in
                viewModel.setColorScheme(newValue)
            }
        }
    }

    init(_ viewModel: Wireframe2DemoViewModel) {
        self.viewModel = viewModel
    }
}
