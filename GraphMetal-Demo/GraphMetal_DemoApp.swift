//
//  GraphMetal_DemoApp.swift
//  GraphMetal-Demo
//
//  Created by Jim Hanson on 4/27/21.
//

import SwiftUI
import Taconic

@main
struct GraphMetal_DemoApp: App {

    @StateObject var demoRegistry = DemoRegistry()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(demoRegistry)
                .preferredColorScheme(.dark)
        }
    }

    init() {
        setDebug(enabled: true)
    }
}
