//
//  SettingsDemoFigure.swift
//  GraphMetal-Demo
//
//  Created by Jim Hanson on 12/13/21.
//

import SwiftUI
import GraphMetal

struct SettingsDemoFigure: View {
    
    @ObservedObject var demo: SettingsDemo
    
    var body: some View {
        ZStack {
            GraphView(demo,
                      renderController: demo.renderController,
                      povController: demo.povController,
                      wireframeSettings: demo.wireframeSettings)
            Overlay(demo.renderController)
        }
    }
}
