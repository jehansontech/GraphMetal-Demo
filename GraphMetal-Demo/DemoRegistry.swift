//
//  Demo.swift
//  GraphMetal-Demo
//
//  Created by Jim Hanson on 4/27/21.
//

import SwiftUI
import UIStuffForSwift

enum DemoType: String, CaseIterable {
    case cube = "Cube"
    case scaleFree = "Scale Free"
}

protocol Demo {

    var type: DemoType { get }

    var name: String { get }

    func setup()

    func teardown()
}


class DemoRegistry: ObservableObject {

    @Published var cube = CubeDemo()

    @Published var scaleFree = ScaleFreeDemo()

    var demoNames: [String] {
        return [cube.name, scaleFree.name]
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
        case scaleFree.name:
            scaleFree.setup()
        default:
            break;
        }
    }

    func teardown(_ name: String) {
        switch name {
        case cube.name:
            cube.teardown()
        case scaleFree.name:
            scaleFree.teardown()
        default:
            break;
        }
    }

    func settingsView(_ name: String) -> some View {
        Group {
            switch name {
            case self.cube.name:
                self.cube.settingsView
            case self.scaleFree.name:
                self.scaleFree.settingsView
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
            case self.scaleFree.name:
                self.scaleFree.displayView
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
