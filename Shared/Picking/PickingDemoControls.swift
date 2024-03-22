//
//  PickingDemoControls.swift
//  GraphMetal-Demo
//
//  Created by Jim Hanson on 12/15/21.
//

import SwiftUI
import GenericGraph
import GraphMetal

struct PickingDemoControls: View {

    static var labelWidth: CGFloat = 80

    @ObservedObject var demo: PickingDemo

    var body: some View {
        Group {
            if demo.selection.nodeNumber == nil {
                Text("(tap or click on a node)")
            }
            else {
                SelectedNodeValueControls2(demo: demo)
            }
        }
    }

//    // NOT USED
//    func centerOnSelection() {
//        if let nodeNumber = demo.selection.nodeNumber,
//           let nodeValue = demo.graph.nodes[nodeNumber]?.value {
//            demo.povController.turnToward(nodeValue.location)
//        }
//    }

//    // NOT USED
//    func deleteSelectedNode() {
//        if let nodeNumber = demo.selection.nodeNumber {
//            demo.selection.clear()
//            demo.graph.removeNode(nodeNumber)
//            demo.fireGraphChange(RenderableGraphChange(nodes: true, edges: true))
//        }
//    }
}

struct SelectedNodeValueControls2: View {

    @ObservedObject var demo: PickingDemo

    @State var nodeLocation: SIMD3<Float> = .zero

    var groupRange: ClosedRange<Int> {
        return 0...(PickingDemoNodeValue.groupColors.count-1)
    }

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Node")
                    .frame(width: PickingDemoControls.labelWidth, alignment: .trailing)
                Text(demo.selection.name)
            }

            HStack {
                Text("Group")
                    .frame(width: PickingDemoControls.labelWidth, alignment: .trailing)
                Text("\(demo.selection.group)")
                Stepper("", value: $demo.selection.group, in: groupRange, step: 1) { editing in
                    if !editing {
                        changeGroup()
                    }
                }
                Spacer()
            }
            HStack {
                Text("X")
                    .frame(width: PickingDemoControls.labelWidth, alignment: .trailing)
                Slider(value: $nodeLocation.x, in: -1...1)
            }
            HStack {
                Text("Y")
                    .frame(width: PickingDemoControls.labelWidth, alignment: .trailing)
                Slider(value: $nodeLocation.y, in: -1...1)
            }
            HStack {
                Text("Z")
                    .frame(width: PickingDemoControls.labelWidth, alignment: .trailing)
                Slider(value: $nodeLocation.z, in: -1...1)
            }

            HStack {
                Button {
                    demo.resetGraph()
                } label: {
                    Text("Reset Graph")
                }
            }
            .padding(.top, 10)
            .frame(maxWidth: .infinity)
        }
        .onAppear {
            self.nodeLocation = demo.selection.location
        }
        .onChange(of: demo.selection.nodeNumber) { newValue in
            self.nodeLocation = demo.selection.location
        }
        .onChange(of: nodeLocation) { newValue in
            changeLocation()
            demo.updateFigure(.geometry)
        }
    }

    func changeGroup() {
        if let nodeNumber = demo.selection.nodeNumber,
           let node = demo.graph.nodes[nodeNumber] {
            node.value?.group = demo.selection.group
            demo.updateFigure(.nodeColors)
            demo.selection.copyFrom(node)
        }
    }

    func changeLocation() {
        if let nodeNumber = demo.selection.nodeNumber,
           let node = demo.graph.nodes[nodeNumber] {
            node.value?.location = nodeLocation
            demo.updateFigure(.geometry)
            demo.selection.copyFrom(node)
        }
    }

}
