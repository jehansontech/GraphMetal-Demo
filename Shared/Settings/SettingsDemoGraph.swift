//
//  SettingsDemoGraph.swift
//  GraphMetal-Demo
//
//  Created by Jim Hanson on 12/13/21.
//

import GenericGraph
import GraphMetal

struct SettingsDemoNodeValue: EmbeddedValue & ColoredValue {

    var color: SIMD4<Float>? { return nil }

    var location: SIMD3<Float>

    init(_ location: SIMD3<Float>) {
        self.location = location
    }
}

struct SettingsDemoEdgeValue: ColoredValue {

    var color: SIMD4<Float>? { nil }
}

typealias SettingsDemoGraph = BaseGraph<SettingsDemoNodeValue, SettingsDemoEdgeValue>
