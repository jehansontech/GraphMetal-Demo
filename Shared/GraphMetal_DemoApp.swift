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

    @StateObject var appModel = AppModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appModel)
        }
    }

    init() {
        setDebug(enabled: true)
    }
}
