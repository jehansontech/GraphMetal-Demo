//
//  PickingDemoFigure.swift
//  GraphMetal-Demo
//
//  Created by Jim Hanson on 12/15/21.
//

import SwiftUI
import GraphMetal
import Wacoma

struct PickingDemoFigure: View {
    
    @Environment(\.colorScheme) private var colorScheme

    @ObservedObject var demo: PickingDemo
    
    var body: some View {
        ZStack {
            ZRendererView(demo.renderer,
                         GestureHandlers(primaryTap: demo,
                                         primaryDrag: demo.renderer,
                                         pinch: demo.renderer,
                                         rotation: demo.renderer))
            ZOverlay(demo.renderer)
        }
        .onChange(of: colorScheme) { newValue in
            demo.setColorScheme(newValue)
        }

    }
}
