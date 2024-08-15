//
//  OldWireframeFigure.swift
//  GraphMetal-Demo
//
//  Created by Jim Hanson on 8/15/24.
//

import SwiftUI
import GraphMetal
import Wacoma

struct OldWireframeFigure: View {

    @Environment(\.colorScheme) private var colorScheme

    @ObservedObject var demo: OldWireframeDemo

    var body: some View {
        ZStack {
            RendererView(demo.renderer,
                          GestureHandlers(primaryDrag: demo.renderer,
                                          pinch: demo.renderer,
                                          rotation: demo.renderer))
        }
        .onChange(of: colorScheme) { newValue in
            demo.setColorScheme(newValue)
        }

    }
}
