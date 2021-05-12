//
//  Demo.swift
//  GraphMetal-Demo
//
//  Created by Jim Hanson on 4/27/21.
//

import SwiftUI
import WacomaUI

enum DemoType: String, CaseIterable {
    case cube = "Cube"
    case ball = "Ball"
}

protocol Demo {

    var type: DemoType { get }

    var name: String { get }

    func setup()

    func teardown()
}


class DemoRegistry: ObservableObject {

    var cube = CubeDemo()

    var randomGrowth = BallDemo()

    var demoNames: [String] {
        return [cube.name, randomGrowth.name]
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
        case cube.name:
            cube.setup()
        case randomGrowth.name:
            randomGrowth.setup()
        default:
            break;
        }
    }

    func teardown(_ name: String) {
        switch name {
        case cube.name:
            cube.teardown()
        case randomGrowth.name:
            randomGrowth.teardown()
        default:
            break;
        }
    }

    func settingsView(_ name: String) -> some View {
        Group {
            switch name {
            case self.cube.name:
                self.cube.settingsView
            case self.randomGrowth.name:
                self.randomGrowth.settingsView
            default:
                EmptySettingsView()
            }
        }
    }

    func displayView(_ name: String) -> some View {
        Group {
            switch name {
            case self.cube.name:
                self.cube.displayView
            case self.randomGrowth.name:
                self.randomGrowth.displayView
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
        .foregroundColor(UIConstants.offWhite)
        .background(UIConstants.offBlack)
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
        .foregroundColor(UIConstants.offWhite)
        .background(UIConstants.offBlack)
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
    }
}
