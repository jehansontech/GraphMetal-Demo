//
//  Demo.swift
//  GraphMetal-Demo
//
//  Created by Jim Hanson on 12/13/21.
//

import Foundation

enum DemoType: String, CaseIterable {
    case cube = "Cube"
    case ball = "Ball"
    case editing = "Editing"
    case appearance = "Settings"
}

protocol Demo: AnyObject {

    var type: DemoType { get }

    var info: String { get }
}

