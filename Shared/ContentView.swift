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

    static let sidebarWidth: CGFloat = 300

    @EnvironmentObject private var displayState: DisplayState
    
    @EnvironmentObject private var demoRegistry: DemoRegistry
    
    var controlsInsets = EdgeInsets(top: 5, leading: 10, bottom: 0, trailing: 10)

    var body: some View {
        HStack(spacing: 0) {
            if displayState.sidebarVisible {
                VStack {
                    DemoDescriptionView(registry: demoRegistry,
                                        demoType: $displayState.demo)
                    demoRegistry.controlsView(displayState.demo)
                    .padding(controlsInsets)
                    Spacer()
                }
                .frame(maxWidth: Self.sidebarWidth)
            }
            demoRegistry.figureView(displayState.demo)
        }
    }
}

struct DemoDescriptionView: View {
    
    @ObservedObject var registry: DemoRegistry
    
    @Binding var demoType: DemoType
    
    var titleInsets = EdgeInsets(top: 25, leading: 20, bottom: 0, trailing: 20)
    var infoboxInsets = EdgeInsets(top: 0, leading: 20, bottom: 20, trailing: 20)
    
    var body: some View {
        VStack {
            Text(demoType.rawValue)
                .font(.headline.smallCaps())
                .padding(titleInsets)
            Text(registry.info(demoType))
                .padding(infoboxInsets)
        }
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
