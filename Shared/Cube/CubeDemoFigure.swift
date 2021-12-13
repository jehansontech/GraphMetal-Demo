//
//  CubeDemoFigure.swift
//  GraphMetal-Demo
//
//  Created by Jim Hanson on 12/13/21.
//

import SwiftUI
import GraphMetal

struct CubeDemoFigure: View {

    @ObservedObject var demo: CubeDemo

    var body: some View {
        GraphView(demo,
                  renderController: demo.renderController,
                  povController: demo.povController,
                  wireframeSettings: demo.wireframeSettings)
    }
}
