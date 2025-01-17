//
//  Renderer+Extensions.swift
//  GraphMetal-Demo
//
//  Created by Jim Hanson on 1/17/25.
//

import SwiftUI
import GraphMetal

extension Renderer {
    public func setColorScheme(_ colorScheme: ColorScheme) {
        // print("ZRenderer.setColorScheme: entered")
        switch colorScheme {
        case .dark:
            self.backgroundRenderColor = RenderConstants.darkBackground
            break
        case .light:
            self.backgroundRenderColor = RenderConstants.lightBackground
            break
        @unknown default:
            break
        }
    }
}

