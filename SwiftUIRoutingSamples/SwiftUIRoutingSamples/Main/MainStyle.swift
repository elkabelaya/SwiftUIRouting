//
//  FeatureAStyle.swift
//  SwiftUIRoutingSamples
//
//  Created by elka belaya  on 07.04.2026.
//

import SwiftUI

public extension View {
    func mainStyle() -> some View {
        VStack {
            Text("Inside Main")
                .font(.largeTitle)
                .bold()
                .padding(.top, 80)
            Spacer()
            self
            Spacer()
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea(edges: .all)
        .background(Color.teal)
        .foregroundStyle(.white)
        .font(Font.body)
    }
}
