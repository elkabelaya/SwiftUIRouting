//
//  ContentView.swift
//  SwiftUIRoutingSamples
//
//  Created by elka belaya  on 07.04.2026.
//

import SwiftUI
import SwiftUIRouting

struct ListView: View {
    private var showCloseButton: Bool
    @StateObject private var router: MainRouter
    
    init(router: MainRouter, showCloseButton: Bool = false) {
        _router = StateObject(wrappedValue: router)
        self.showCloseButton = showCloseButton
    }
    
    var body: some View {
        VStack(spacing: 20) {
            ForEach(1..<4) {index in
                Button("Item \(index)") {
                    router.navigateTo(.detail(1))
                }
            }
            Button("Navigate to Feature A") {
                router.navigateTo(.featureA)
            }
            Button("Replace Me to Feature A") {
                router.replaceTop(.featureA)
            }
        }
        .mainStyle()
    }
}

#Preview {
    ListView(router: MainRouter(isPresented: .constant(true)))
}
