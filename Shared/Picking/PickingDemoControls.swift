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
            if demo.selection.id == nil {
                Text("(tap or click on a node)")
            }
            else {
                SelectedNodeValueControls(demo: demo)
            }
        }
    }

    // NOT USED
    func centerOnSelection() {
        if let nodeID = demo.selection.id,
           let nodeValue = demo.graph.nodes[nodeID]?.value {
            demo.povController.centerOn(nodeValue.location)
        }
    }

    // NOT USED
    func deleteSelectedNode() {
        if let nodeID = demo.selection.id {
            demo.selection.clear()
            demo.graph.removeNode(nodeID)
            demo.fireGraphChange(RenderableGraphChange(nodes: true, edges: true))
        }
    }
}

struct SelectedNodeValueControls: View {

    @ObservedObject var demo: PickingDemo

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
                Slider(value: $demo.selection.x, in: -1...1) { editing in
                    if !editing {
                        changeLocation()
                    }
                }
            }
            HStack {
                Text("Y")
                    .frame(width: PickingDemoControls.labelWidth, alignment: .trailing)
                Slider(value: $demo.selection.y, in: -1...1) { editing in
                    if !editing {
                        changeLocation()
                    }
                }
            }
            HStack {
                Text("Z")
                    .frame(width: PickingDemoControls.labelWidth, alignment: .trailing)
                Slider(value: $demo.selection.z, in: -1...1) { editing in
                    if !editing {
                        changeLocation()
                    }
                }
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
    }

    func changeGroup() {
        if let nodeID = demo.selection.id,
           let node = demo.graph.nodes[nodeID] {
            node.value?.group = demo.selection.group
            demo.fireGraphChange(RenderableGraphChange(nodeColors: true))
            demo.selection.copyFrom(node)
        }
    }

    func changeLocation() {
        if let nodeID = demo.selection.id,
           let node = demo.graph.nodes[nodeID] {
            node.value?.location = demo.selection.location
            demo.fireGraphChange(RenderableGraphChange(nodePositions: true))
            demo.selection.copyFrom(node)
        }
    }

}
