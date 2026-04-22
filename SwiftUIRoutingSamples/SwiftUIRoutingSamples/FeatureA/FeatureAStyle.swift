//
//  FeatureAStyle.swift
//  SwiftUIRoutingSamples
//
//  Created by elka belaya  on 07.04.2026.
//

import SwiftUI

public extension View {
    func featureAStyle() -> some View {
        VStack {
            Text("Inside Feature A")
                .font(.largeTitle)
                .bold()
                .padding(.top, 80)
            Spacer()
            self
            Spacer()
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea(edges: .all)
        .background(.mint)
        .foregroundStyle(.white)
        .font(Font.body)
    }
}
