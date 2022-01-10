//
//  SettingsDemoFigure.swift
//  GraphMetal-Demo
//
//  Created by Jim Hanson on 12/13/21.
//

import SwiftUI
import GraphMetal
import Wacoma

struct SettingsDemoFigure: View {

    @ObservedObject var demo: SettingsDemo

    var body: some View {
        ZStack {
            RendererView(demo.renderController,
                         GestureHandlers(dragHandler: demo.povController,
                                         pinchHandler: demo.povController,
                                         rotationHandler: demo.povController))
            Overlay(demo.renderController)
        }
    }
}
