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
            RendererView(demo.renderController,
                         GestureHandlers(tapHandler: demo,
                                         dragHandler: demo.povController,
                                         pinchHandler: demo.povController,
                                         rotationHandler: demo.povController))
            Overlay(demo.renderController)
        }
        .onChange(of: colorScheme) { newValue in
            demo.setColorScheme(newValue)
        }

    }
}
