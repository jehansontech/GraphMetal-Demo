//
//  PickingDemoFigure.swift
//  GraphMetal-Demo
//
//  Created by Jim Hanson on 12/15/21.
//

import SwiftUI
import GraphMetal

struct PickingDemoFigure: View {

    @ObservedObject var demo: PickingDemo

    var body: some View {
        ZStack {
            GraphView(demo,
                      renderController: demo.renderController,
                      povController: demo.povController,
                      tapHandler: demo)
            Overlay(demo.renderController)
        }
    }
}
