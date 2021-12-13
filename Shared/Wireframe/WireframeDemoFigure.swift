//
//  WireframeDemoFigure.swift
//  GraphMetal-Demo
//
//  Created by Jim Hanson on 12/13/21.
//

import SwiftUI
import GraphMetal

struct WireframeDemoFigure: View {

    var demo: WireframeDemo

    var body: some View {
        GraphView(demo,
                  povController: demo.povController,
                  wireframeSettings: demo.wireframeSettings)
    }
}
