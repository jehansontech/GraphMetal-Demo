//
//  MonochromeSettingsFigure.swift
//  GraphMetal-Demo
//
//  Created by Jim Hanson on 8/10/24.
//

import SwiftUI
import GraphMetal
import Wacoma

struct MonochromeSettingsFigure: View {

    @Environment(\.colorScheme) private var colorScheme

    @ObservedObject var demo: MonochromeSettingsDemo

    var body: some View {
        ZStack {
            ZRendererView(demo.renderer,
                          GestureHandlers(primaryDrag: demo.renderer,
                                          pinch: demo.renderer,
                                          rotation: demo.renderer))
        }
        .onChange(of: colorScheme) { newValue in
            demo.setColorScheme(newValue)
        }

    }
}
