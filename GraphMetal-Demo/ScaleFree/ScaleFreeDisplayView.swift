//
//  ScaleFreeDisplayView.swift
//  GraphMetal-Demo
//
//  Created by Jim Hanson on 4/27/21.
//

import SwiftUI
import UIStuffForSwift

struct ScaleFreeDisplayView: View {

    @EnvironmentObject var registry: DemoRegistry

    @ObservedObject var settings: ScaleFreeSettings

    var body: some View {
        VStack {
            HStack {
                Text("scale free coming soon")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .foregroundColor(UIConstants.offWhite)
        .background(UIConstants.offBlack)
        .navigationTitle("\(registry.scaleFree.name)")
        .navigationBarTitleDisplayMode(.inline)
    }

    init(_ settings: ScaleFreeSettings) {
        self.settings = settings
    }

}
