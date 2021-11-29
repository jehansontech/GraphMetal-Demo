//
//  DemoDisplayView.swift
//  GraphMetal-Demo
//
//  Created by Jim Hanson on 4/27/21.
//

import Foundation

import SwiftUI

struct DemoDisplayView: View {

    @EnvironmentObject var demoRegistry: DemoRegistry

    var body: some View {
        demoRegistry.displayView(demoRegistry.selectionName)
            // .foregroundColor(UIConstants.offWhite)
            // .background(UIConstants.offBlack)
            .navigationTitle("\(demoRegistry.selectionName)")
            //.navigationBarTitleDisplayMode(.inline)

    }
}
