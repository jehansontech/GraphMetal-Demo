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
                         GestureHandlers(primaryDrag: demo.renderController,
                                         pinch: demo.renderController,
                                         rotation: demo.renderController))
            Overlay(demo.renderController)
        }
    }
}
