//
//  CubeDemoFigure.swift
//  GraphMetal-Demo
//
//  Created by Jim Hanson on 12/13/21.
//

import SwiftUI
import GraphMetal
import Wacoma

struct CubeDemoFigure: View {

    @Environment(\.colorScheme) private var colorScheme

    @ObservedObject var demo: CubeDemo

    var body: some View {
        ZStack {
            RendererView(demo.renderController,
                         GestureHandlers(primaryDrag: demo.renderController,
                                         pinch: demo.renderController,
                                         rotation: demo.renderController))
            Overlay(demo.renderController)
        }
        .onChange(of: colorScheme) { newValue in
            demo.setColorScheme(newValue)
        }
    }
}
