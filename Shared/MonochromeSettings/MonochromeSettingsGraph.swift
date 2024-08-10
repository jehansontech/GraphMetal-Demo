//
//  MonochromeSettingsGraph.swift
//  GraphMetal-Demo
//
//  Created by Jim Hanson on 8/10/24.
//

import GenericGraph
import GraphMetal

struct MonochromeSettingsNodeValue: EmbeddedValue {

    var location: SIMD3<Float>

    init(_ location: SIMD3<Float>) {
        self.location = location
    }
}

typealias MonochromeSettingsGraph = BaseGraph<MonochromeSettingsNodeValue, Void>
