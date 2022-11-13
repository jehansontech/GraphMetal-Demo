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
                         GestureHandlers(dragHandler: demo.renderController,
                                         pinchHandler: demo.renderController,
                                         rotationHandler: demo.renderController))
            Overlay(demo.renderController)
        }
    }
}
