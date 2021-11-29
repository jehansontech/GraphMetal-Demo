//
//  Demo.swift
//  GraphMetal-Demo
//
//  Created by Jim Hanson on 4/27/21.
//

import SwiftUI

enum DemoType: String, CaseIterable {
    case cube = "Cube"
    case ball = "Ball"
    case dimming = "Dimming"
}

protocol Demo {

    var type: DemoType { get }

    var name: String { get }

    func setup()

    func teardown()
}


class DemoRegistry: ObservableObject {

    var ball = BallDemo()

    var cube = CubeDemo()

    var dimming = DimmingDemo()

    var demoNames: [String] {
        return [ball.name, cube.name, dimming.name]
    }

    @Published var selectionName: String = ""

    func select(_ name: String) {
        if name == selectionName {
            return
        }
        teardown(selectionName)
        selectionName = name
        setup(selectionName)
    }

    func setup(_ name: String) {
        switch name {
        case ball.name:
            ball.setup()
        case cube.name:
            cube.setup()
        case dimming.name:
            dimming.setup()
        default:
            break;
        }
    }

    func teardown(_ name: String) {
        switch name {
        case ball.name:
            ball.teardown()
        case cube.name:
            cube.teardown()
        case dimming.name:
            dimming.teardown()
        default:
            break;
        }
    }

    func settingsView(_ name: String) -> some View {
        Group {
            switch name {
            case self.ball.name:
                self.ball.settingsView
            case self.cube.name:
                self.cube.settingsView
            case self.dimming.name:
                self.dimming.settingsView
            default:
                EmptySettingsView()
            }
        }
    }

    func displayView(_ name: String) -> some View {
        Group {
            switch name {
            case self.ball.name:
                self.ball.displayView
            case self.cube.name:
                self.cube.displayView
            case self.dimming.name:
                self.dimming.displayView
            default:
                EmptyDisplayView()
            }
        }
    }
}

struct EmptySettingsView: View {

    var body: some View {
        VStack {
            HStack {
                Text("")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        // .foregroundColor(UIConstants.offWhite)
        // .background(UIConstants.offBlack)
    }
}

struct EmptyDisplayView: View {

    var body: some View {
        VStack {
            HStack {
                Text("")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        // .foregroundColor(UIConstants.offWhite)
        // .background(UIConstants.offBlack)
        .navigationTitle("")
        //.navigationBarTitleDisplayMode(.inline)
    }
}
