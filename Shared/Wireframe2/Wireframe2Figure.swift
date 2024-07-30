//
//  Wireframe2Figure.swift
//  GraphMetal-Demo
//
//  Created by Jim Hanson on 7/30/24.
//

import SwiftUI
import GraphMetal
import Wacoma

struct Wireframe2Figure: View {

    @Environment(\.colorScheme) private var colorScheme

    @ObservedObject var demo: Wireframe2Demo

    var body: some View {
        ZStack {
            RendererView(demo.renderController,
                         GestureHandlers(primaryDrag: demo.renderController,
                                         pinch: demo.renderController,
                                         rotation: demo.renderController))
        }
        .onChange(of: colorScheme) { newValue in
            demo.setColorScheme(newValue)
        }

    }
}
