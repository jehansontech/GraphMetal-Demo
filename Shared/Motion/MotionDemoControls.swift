//
//  MotionControls.swift
//  GraphMetal-Demo (iOS)
//
//  Created by Jim Hanson on 12/14/21.
//

import SwiftUI

struct MotionDemoControls: View {

    @ObservedObject var demo: MotionDemo

    var body: some View {
        Text(demo.info)
    }
}
