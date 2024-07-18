//
//  Wireframe2DemoControls.swift
//  GraphMetal-Demo
//
//  Created by Jim Hanson on 7/12/24.
//

import SwiftUI
import GraphMetal

struct Wireframe2DemoControls: View {

    @ObservedObject var viewModel: Wireframe2DemoViewModel

    var body: some View {
        if !viewModel.isConnected {
            EmptyView()
        }
        else {
            VStack(alignment: .center, spacing: 20) {
                Text("ViewModel is connected")
            }
        }
    }

    init(_ viewModel: Wireframe2DemoViewModel) {
        self.viewModel = viewModel
    }
}

