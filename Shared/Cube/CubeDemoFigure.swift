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
            RendererView(demo.renderer,
                         GestureHandlers(primaryDrag: demo.renderer,
                                         pinch: demo.renderer,
                                         rotation: demo.renderer))
            ZOverlay(demo.renderer)
        }
        .onChange(of: colorScheme) { newValue in
            demo.setColorScheme(newValue)
        }
    }
}
