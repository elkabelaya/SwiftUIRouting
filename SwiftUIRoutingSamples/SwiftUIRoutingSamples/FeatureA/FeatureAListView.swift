//
//  FeatureAListView.swift
//  SwiftUIRoutingSamples
//
//  Created by elka belaya  on 03.04.2026.
//

import SwiftUI
import SwiftUIRouting

struct FeatureAListView: View {
    
    @StateObject private var router: FeatureARouter
    
    init(router: FeatureARouter) {
        _router = StateObject(wrappedValue: router)
    }
    
    var body: some View {
            VStack(spacing: 20) {
                Button("Item") {
                    router.navigateTo(.detail(1))
                }
            }
            .featureAStyle()
    }
}

#Preview {
    ListView(router: MainRouter(isPresented: .constant(true)))
}
