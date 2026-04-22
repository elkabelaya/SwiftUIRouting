//
//  FeatureAView.swift
//  SwiftUIRoutingSamples
//
//  Created by elka belaya  on 03.04.2026.
//

import SwiftUI
import SwiftUIRouting

struct FeatureAView: View {
    
    @StateObject private var router: FeatureARouter
    
    init(router: FeatureARouter) {
        _router = StateObject(wrappedValue: router)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            Button("Present List") {
                router.navigateTo(.list)
            }
            Button("Present Detail") {
                router.navigateTo(.detail(1))
            }
            Button("Dismiss") {
                router.dismiss()
            }
        }
        .featureAStyle()
    }
}

#Preview {
    FeatureAView(router: FeatureARouter(isPresented: .constant(true)))
}
