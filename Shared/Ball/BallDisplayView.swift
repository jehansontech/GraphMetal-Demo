//
//  BallDisplayView.swift
//  GraphMetal-Demo
//
//  Created by Jim Hanson on 5/10/21.
//

import SwiftUI
import GraphMetal

struct BallDisplayView : View {

    @ObservedObject var demo: BallDemo

    @State var rendererSettings = RendererSettings(nodeSize: 20,
                                               nodeSizeAutomatic: false)

    var body: some View {
        GraphView($rendererSettings, demo, demo.povController!)
            .navigationTitle("\(demo.name)")
            //.navigationBarTitleDisplayMode(.inline)
    }

    init(_ demo: BallDemo) {
        self.demo = demo
    }

}
