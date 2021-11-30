//
//  ContentView.swift
//  GraphMetal-Demo
//
//  Created by Jim Hanson on 4/27/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
            DisplayControls()
                .padding()
            PageView()
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct NavigationBarStyle: ViewModifier {

    @EnvironmentObject var model: AppModel

    func body(content: Content) -> some View {
        content
            .foregroundColor(Color.red)// navigationBarTitle("sdfsdfs")
    }
}

struct DisplayControls: View {

    @EnvironmentObject var model: AppModel

    var body: some View {
        HStack(alignment: .center, spacing: 10) {

            Button(action: {
                model.toggleColorScheme()
            }) {
                Image(systemName: "sun.max.fill")
            }

            Picker("", selection: $model.currentPage) {
                ForEach(Page.allCases, id: \.self) { p in
                    Text(p.rawValue).tag(p)
                }
            }
            .pickerStyle(.segmented)

            Spacer()
        }
        .preferredColorScheme(model.colorScheme) // put it here for convenience
    }
}

struct PageView : View {

    @EnvironmentObject var appModel: AppModel

    var body: some View {
        switch appModel.currentPage {
        case .ball:
            BallDemoView(appModel.ball)
        case .cube:
            CubeDemoView(appModel.cube)
        case .dimming:
            DimmingDemoView(appModel.dimming)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
