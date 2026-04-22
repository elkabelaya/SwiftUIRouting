//
//  ContentView.swift
//  SwiftUIRoutingSamples
//
//  Created by elka belaya  on 07.04.2026.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var router = MainRouter(isPresented: .constant(true))
    
    var body: some View {
        MainView(router: router)
    }
}

#Preview {
    ContentView()
}
