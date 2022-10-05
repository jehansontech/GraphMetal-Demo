////
////  CubeDemoViewModel.swift
////  GraphMetal-Demo
////
////  Created by Jim Hanson on 10/5/22.
////
//
//import SwiftUI
//import Wacoma
//import GraphMetal
//
//@MainActor
//class CubeDemoViewModel: ObservableObject {
//
//    static var defaultOrbitEnabled: Bool = true
//
//    static var defaultOrbitSpeed: Float = .pi/30
//
//    static var defaultFadeoutMidpoint: Float = 40
//
//    static var defaultFadeoutDistance: Float = 40
//
//    static var graphColor = SIMD4<Float>(1, 0, 0.5, 1)
//
//    static var initialPOV = CenteredPOV(location: SIMD3<Float>(30, 0, -120))
//
//    static var defaultPOV = CenteredPOV(location: SIMD3<Float>(10, 0, -48))
//
//    var graph: CubeDemoGraph
//
//    var povController: OrbitingPOVController
//
//    var fovController: PerspectiveFOVController
//
//    var renderController: RenderController
//
//    var wireframe2: Wireframe2
//
//    init() {
//
//    }
//}
