//
//  ContentView.swift
//  GraphMetal-Demo
//
//  Created by Jim Hanson on 4/27/21.
//

import SwiftUI
import UIStuffForSwift

struct ContentView: View {
    var body: some View {
        NavigationView {
            DemoSelectorView()
            DemoDisplayView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
