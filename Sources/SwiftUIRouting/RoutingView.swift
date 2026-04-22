//
//  Navigable.swift
//  SwiftUIRouting
//
//  Created by elka belaya  on 03.04.2026.
//

import SwiftUI
fileprivate struct RoutingModifier: ViewModifier {
    @StateObject var navigation: Navigation
    
    func body(content: Content) -> some View {
        NavigationStack(path: $navigation.path) {
            content
        }
    }
}

public extension View {
    func navigationStack(_ navigation: Navigation) -> some View {
        self.modifier(RoutingModifier(navigation: navigation))
    }
    
    func router<Routing: Routable >(_ router: Router<Routing>) -> some View {
        self
            .navigationDestination(for: Routing.self) { spec in
                router.navigation(routing: spec)
            }
            .sheet(item: router.presentingSheet) { spec in
                router.modal(routing: spec, rootPresented: router.isPresentingSheet)
            }
            .fullScreenCover(item: router.presentingFullScreenCover) { spec in
                router.modal(routing: spec, rootPresented: router.isPresentingFullScreenCover)
            }
            .alert(item: router.presentingAlert) { spec in
                router.alert(routing: spec, rootPresented: router.isPresentingAlert)
            }
    }    
}
