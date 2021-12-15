//
//  MotionDemoFigure.swift
//  GraphMetal-Demo (iOS)
//
//  Created by Jim Hanson on 12/14/21.
//

import SwiftUI
import GraphMetal

struct MotionDemoFigure: View {

    @ObservedObject var demo: MotionDemo

    var body: some View {
        GraphView(demo)
    }
}
