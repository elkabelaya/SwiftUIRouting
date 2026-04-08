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
//    
//    func router<Routing: Routable, Resolver: NavigationResolver>(
//        _ router: Router<Routing>,
//        _ resolver: Resolver
//    ) -> some View where Routing == Resolver.Routing {
//        self
//            .navigationDestination(for: Routing.self) { spec in
//                resolver.view(spec: spec)
//            }
//    }
//
//    func router<Routing: Routable, Resolver: ModalResolver >(
//        _ router: Router<Routing>,
//        _ resolver: Resolver
//    ) -> some View where Routing == Resolver.Routing {
//        self
//            .sheet(item: router.presentingSheet) { spec in
//                resolver.view(spec: spec, rootPresented: router.isPresentingSheet)
//            }
//            .fullScreenCover(item: router.presentingFullScreen) { spec in
//                resolver.view(spec: spec, rootPresented: router.isPresentingFullScreen)
//            }
//    }
//    
//    func router<Routing: Routable, Resolver: AlertResolver >(
//        _ router: Router<Routing>,
//        _ resolver: Resolver
//    ) -> some View where Routing == Resolver.Routing {
//        self
//            .alert(item: router.presentingAlert) { spec in
//                resolver.alert(spec: spec, rootPresented: router.isPresentingAlert)
//            }
//    }
//    
//    func router<Routing: Routable, Resolver: AlertNavigationResolver >(
//        _ router: Router<Routing>,
//        _ resolver: Resolver
//    ) -> some View where Routing == Resolver.Routing {
//        self
//            .navigationDestination(for: Routing.self) { spec in
//                resolver.view(spec: spec)
//            }
//            .alert(item: router.presentingAlert) { spec in
//                resolver.alert(spec: spec, rootPresented: router.isPresentingAlert)
//            }
//    }
//    
//    func router<Routing: Routable, Resolver: NavigationModalResolver >(
//        _ router: Router<Routing>,
//        _ resolver: Resolver
//    ) -> some View where Routing == Resolver.Routing {
//        self
//            .navigationDestination(for: Routing.self) { spec in
//                resolver.view(spec: spec)
//            }
//            .sheet(item: router.presentingSheet) { spec in
//                resolver.view(spec: spec, rootPresented: router.isPresentingSheet)
//            }
//            .fullScreenCover(item: router.presentingFullScreen) { spec in
//                resolver.view(spec: spec, rootPresented: router.isPresentingFullScreen)
//            }
//    }
//    
//    func router<Routing: Routable, Resolver: FullResolver >(
//        _ router: Router<Routing>,
//        _ resolver: Resolver
//    ) -> some View where Routing == Resolver.Routing {
//        self
//            .navigationDestination(for: Routing.self) { spec in
//                resolver.view(spec: spec)
//            }
//            .sheet(item: router.presentingSheet) { spec in
//                resolver.view(spec: spec, rootPresented: router.isPresentingSheet)
//            }
//            .fullScreenCover(item: router.presentingFullScreen) { spec in
//                resolver.view(spec: spec, rootPresented: router.isPresentingFullScreen)
//            }
//            .alert(item: router.presentingAlert) { spec in
//                resolver.alert(spec: spec, rootPresented: router.isPresentingAlert)
//            }
//    }
//    
//    func router<Routing, T: NavigationResolver>(_ router: T) -> some View
//    where Routing == T.Routing, T: Router<Routing> {
//        self.router(router, router)
//    }
//    
//    func router<Routing, T: ModalResolver>(_ router: T) -> some View
//    where Routing == T.Routing, T: Router<Routing> {
//        self.router(router, router)
//    }
//    
//    func router<Routing, T: AlertResolver>(_ router: T) -> some View
//    where Routing == T.Routing, T: Router<Routing> {
//        self.router(router, router)
//    }
//    
//    func router<Routing, T: AlertNavigationResolver>(_ router: T) -> some View
//    where Routing == T.Routing, T: Router<Routing> {
//        return self.router(router, router)
//    }
//    
//    func router<Routing, T: NavigationModalResolver>(_ router: T) -> some View
//    where Routing == T.Routing, T: Router<Routing> {
//        return self.router(router, router)
//    }
//    
//    func router<Routing, T: FullResolver>(_ router: T) -> some View
//    where Routing == T.Routing, T: Router<Routing> {
//        return self.router(router, router)
//    }
    
}


extension View {
    
}
