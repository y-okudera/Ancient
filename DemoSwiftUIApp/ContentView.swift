//
//  ContentView.swift
//  DemoSwiftUIApp
//
//  Created by okudera on 2023/06/27.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ANCComicViewerContainerViewControllerRepresentable()
            .edgesIgnoringSafeArea(.all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
