////
////  XWireframeFigure.swift
////  GraphMetal-Demo
////
////  Created by Jim Hanson on 8/15/24.
////
//
//import SwiftUI
//import GraphMetal
//import Wacoma
//
//struct XWireframeFigure: View {
//
//    @Environment(\.colorScheme) private var colorScheme
//
//    @ObservedObject var demo: XWireframeDemo
//
//    var body: some View {
//        ZStack {
//            XRendererView(demo.renderer,
//                          GestureHandlers(primaryDrag: demo.renderer,
//                                          pinch: demo.renderer,
//                                          rotation: demo.renderer))
//        }
//        .onChange(of: colorScheme) { newValue in
//            demo.setColorScheme(newValue)
//        }
//
//    }
//}
