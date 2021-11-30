//
//  AppModel.swift
//  GraphMetal-Demo
//
//  Created by Jim Hanson on 11/29/21.
//

import SwiftUI

enum Page: String, CaseIterable {
    case cube = "Cube"
    case ball = "Ball"
    case dimming = "Dimming"
}

class AppModel: ObservableObject {

    @Published var colorScheme = ColorScheme.dark

    @Published var currentPage: Page = .cube

    @Published var ball = BallDemo()

    @Published var cube = CubeDemo()

    @Published var dimming = DimmingDemo()

    func toggleColorScheme() {
        switch colorScheme {
        case .dark:
            colorScheme = .light
        case .light:
            colorScheme = .dark
        @unknown default:
            fatalError("Unknown color scheme")
        }
    }

}
