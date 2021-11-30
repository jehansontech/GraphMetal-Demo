//
//  UIConstants.swift
//  GraphMetal-Demo
//
//  Created by Jim Hanson on 11/30/21.
//

import SwiftUI

struct UIConstants {

    static let settingsViewWidth: CGFloat = 300

    static let settingInsets = EdgeInsets(top: 0, leading: 30, bottom: 0, trailing: 0)
}

struct SettingLabelStyle: ViewModifier {

    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct SettingControlStyle: ViewModifier {

    func body(content: Content) -> some View {
        content
            .padding(UIConstants.settingInsets)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

extension View {

    public func settingLabel() -> some View {
        self.modifier(SettingLabelStyle())
    }

    public func settingControl() -> some View {
        self.modifier(SettingControlStyle())
    }
}
