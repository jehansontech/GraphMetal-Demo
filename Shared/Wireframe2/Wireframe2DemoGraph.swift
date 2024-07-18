//
//  Wireframe2DemoGraph.swift
//  GraphMetal-Demo
//
//  Created by Jim Hanson on 7/13/24.
//

import GenericGraph
import GraphMetal

struct Wireframe2DemoNodeValue: EmbeddedValue & ColoredValue {

    var color: SIMD4<Float>? = nil
    var location: SIMD3<Float> = .zero
}

struct Wireframe2DemoEdgeValue: ColoredValue {
    
    var color: SIMD4<Float>? = nil

}

typealias Wireframe2DemoGraph = BaseGraph<Wireframe2DemoNodeValue, Wireframe2DemoEdgeValue>
