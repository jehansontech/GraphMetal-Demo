//
//  WireframeDemoFigure.swift
//  GraphMetal-Demo
//
//  Created by Jim Hanson on 12/13/21.
//

import SwiftUI
import GraphMetal

struct AppearanceDemoFigure: View {
    
    @ObservedObject var demo: AppearanceDemo
    
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
