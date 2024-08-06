//
//  ZWireframeFigure.swift
//  GraphMetal-Demo
//
//  Created by Jim Hanson on 7/30/24.
//

import SwiftUI
import GraphMetal
import Wacoma

struct ZWireframeFigure: View {

    @Environment(\.colorScheme) private var colorScheme

    @ObservedObject var demo: ZWireframeDemo

    var body: some View {
        ZStack {
            ZRendererView(demo.renderer,
                         GestureHandlers(primaryDrag: demo.renderer,
                                         pinch: demo.renderer,
                                         rotation: demo.renderer))
        }
        .onChange(of: colorScheme) { newValue in
            demo.setColorScheme(newValue)
        }

    }
}
