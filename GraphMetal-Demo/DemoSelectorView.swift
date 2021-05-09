//
//  DemoSelector.swift
//  GraphMetal-Demo
//
//  Created by Jim Hanson on 4/27/21.
//

import SwiftUI
import UIStuffForSwift

struct DemoSelectorView: View {

    @EnvironmentObject var demoRegistry: DemoRegistry

    @State var group = TwistieGroup().headerStyle(.fill)

    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            Spacer().frame(height: 0) // shift top button down by spacing
            ForEach(demoRegistry.demoNames, id: \.self) { name in
                TwistieSection(name, $group) {
                    demoRegistry.settingsView(name)
                        .onAppear(perform: { demoRegistry.select(name) })
                }
            }
            Spacer()
        }
        .animation(.easeInOut)
        .foregroundColor(UIConstants.offWhite)
        .background(UIConstants.offBlack)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .navigationTitle("Demos")
        .navigationBarTitleDisplayMode(.inline)
    }
}
