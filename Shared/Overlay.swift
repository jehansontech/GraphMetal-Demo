//
//  Overlay.swift
//  GraphMetal-Demo
//
//  Created by Jim Hanson on 12/15/21.
//

import SwiftUI
import GraphMetal

struct Overlay: View {

    @ObservedObject var renderController: RenderController
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top) {

                Button {
                    renderController.requestSnapshot()
                } label:  {
                    Image(systemName: "camera.on.rectangle")
                }
                .padding(4)
                .background(Color.clear)
                .imageScale(.large)
                .help("Take a snapshot of the figure")

                Spacer()
            }

            Spacer()
        }
    }

    init(_ renderController: RenderController) {
        self.renderController = renderController
    }
}
