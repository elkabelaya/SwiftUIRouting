//
//  FeatureADetailView.swift
//  SwiftUIRoutingSamples
//
//  Created by elka belaya  on 06.04.2026.
//

import SwiftUI
import SwiftUIRouting

struct FeatureADetailView: View {
    
    private let index: Int
    @StateObject private var router: FeatureARouter
    
    init(index: Int, router: FeatureARouter) {
        self.index = index
        _router = StateObject(wrappedValue: router)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            Text("Detail deep : \(index)")
                .font(Font.largeTitle.weight(.bold))
            Button("Present Alert") {
                router.presentAlert(.alert)
            }
            
            Button("Present Detail Again") {
                router.navigateTo(.detail(index + 1 ))
            }
            
            Button("PopTo Initial") {
                router.popToInitial()
            }
            
            Button("PopTo Root") {
                router.popToRoot()
            }
        }
        .featureAStyle()
    }
}

