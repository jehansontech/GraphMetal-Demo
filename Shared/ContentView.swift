//
//  ContentView.swift
//  GraphMetal-Demo
//
//  Created by Jim Hanson on 4/27/21.
//

import SwiftUI

struct ContentView: View {

    var body: some View {
        VStack(spacing: 0) {
            DisplayControls()
                .frame(maxWidth: .infinity)
            Divider().frame(maxWidth: .infinity)
            DemoView()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

struct DisplayControls: View {

    @EnvironmentObject private var displayState: DisplayState

    private let insets = EdgeInsets(top: 1, leading: 10, bottom: 0, trailing: 0)

    var body: some View {
        HStack(alignment: .center, spacing: 10) {

            Button(action: {
                displayState.toggleSidebar()
            }) {
                Image(systemName: "sidebar.leading")
                    .imageScale(.large)
            }

            Button(action: {
                displayState.toggleColorScheme()
            }) {
                Image(systemName: "sun.max.fill")
                    .imageScale(.large)
            }

            Picker("", selection: $displayState.demo) {
                ForEach(DemoType.allCases, id: \.self) { p in
                    Text(p.rawValue).tag(p)
                }
            }
            .pickerStyle(.segmented)

        }
        .padding(insets)
        .preferredColorScheme(displayState.colorScheme)
    }
}

struct DemoView : View {

    @EnvironmentObject private var displayState: DisplayState

    @EnvironmentObject private var demoRegistry: DemoRegistry

    var body: some View {
        HStack(spacing: 0) {
            if displayState.sidebarVisible {
                demoRegistry.controlsView(displayState.demo)
                    .padding()
                    .frame(maxWidth: UIConstants.settingsViewWidth, maxHeight: .infinity)
            }
            demoRegistry.figureView(displayState.demo)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
