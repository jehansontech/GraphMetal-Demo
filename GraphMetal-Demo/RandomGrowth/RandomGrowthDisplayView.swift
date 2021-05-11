//
//  RandomGrowthDisplayView.swift
//  GraphMetal-Demo
//
//  Created by Jim Hanson on 5/10/21.
//

import SwiftUI
import GraphMetal

struct RandomGrowthDisplayView : View {

    @ObservedObject var demo: RandomGrowthDemo

    @State var renderSettings = RenderSettings(nodeSize: 20,
                                               nodeSizeAutomatic: false)

    var body: some View {
        RendererView($renderSettings, demo.graphController!, demo.povController!)
            .navigationTitle("\(demo.name)")
            .navigationBarTitleDisplayMode(.inline)
    }

    init(_ demo: RandomGrowthDemo) {
        self.demo = demo
    }

}
