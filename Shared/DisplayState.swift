//
//  DisplayState.swift
//  GraphMetal-Demo
//
//  Created by Jim Hanson on 11/30/21.
//

import SwiftUI

class DisplayState: ObservableObject {

    @Published var sidebarVisible = true

    @Published var colorScheme = ColorScheme.dark

    @Published var demo: DemoType = .cube

    func toggleSidebar() {
        sidebarVisible = !sidebarVisible
    }

    func toggleColorScheme() {
        colorScheme = colorScheme == .dark ? .light : .dark
    }
}
