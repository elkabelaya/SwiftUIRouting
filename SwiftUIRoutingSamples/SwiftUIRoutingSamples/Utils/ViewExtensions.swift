//
//  ViewExtensions.swift
//  SwiftUIRoutingSamples
//
//  Created by elka belaya  on 08.04.2026.
//

import SwiftUI

extension View {
    func showCloseButton(_ isShown: Bool, action: @escaping () -> Void) -> some View {
        self
            .toolbar(content:{
                if isShown {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            action()
                        } label: {
                            Image(systemName: "xmark.circle")
                        }
                    }
                }
            }
            )
    }
}
