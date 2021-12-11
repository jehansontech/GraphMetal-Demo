//
//  GraphMetal_DemoApp.swift
//  GraphMetal-Demo
//
//  Created by Jim Hanson on 4/27/21.
//

import SwiftUI
import Wacoma

@main
struct GraphMetal_DemoApp: App {

    @StateObject var displayState = DisplayState()
    @StateObject var demoRegistry = DemoRegistry()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(displayState)
                .environmentObject(demoRegistry)
        }
    }

    init() {
        setDebug(enabled: true)
    }
}
