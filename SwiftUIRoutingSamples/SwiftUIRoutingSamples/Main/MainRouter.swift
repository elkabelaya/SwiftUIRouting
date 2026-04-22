//
//  ContentView.swift
//  SwiftUIRoutingSamples
//
//  Created by elka belaya  on 07.04.2026.
//

import SwiftUI
import SwiftUIRouting


enum MainRoutes: RouteComparable {
    private static var singleDetailId = UUID()
    var rootId: AnyHashable? {
        switch self {
        case .detail:
            return Self.singleDetailId
        default :
            return nil
        }
    }
    
    var id: Self { self }
    case list
    case detail(Int)
    case alert(String)
    case featureA
}

class MainRouter: Router<MainRoutes> {
    override func modal(routing: MainRoutes, rootPresented: Binding<Bool>) -> AnyView {
        switch routing {
        case .list:
            let router = MainRouter(isPresented: rootPresented)
            return AnyView(ListView(router: router, showCloseButton: true)
                .showCloseButton(true, action: router.dismiss)
                .router(router)
                .navigationStack(router.navigation)
                           
            )
        case .detail(let index):
            let router = MainRouter(isPresented: rootPresented)
            return AnyView(DetailView(index: index, router: router)
                .showCloseButton(true, action: router.dismiss)
                .router(router)
                .navigationStack(router.navigation)
            )
        case .featureA:
            let router = FeatureARouter(isPresented: rootPresented)
            return AnyView(FeatureAView(router: router)
                .showCloseButton(true, action: router.dismiss)
                .router(router)
                .navigationStack(router.navigation)
            )
        default:
            return AnyView(EmptyView())
        }
    }
    
    override func navigation(routing: MainRoutes) -> AnyView {
        switch routing {
        case .list:
            return AnyView(ListView(router: self, showCloseButton: false))
        case .detail(let index):
            return AnyView(DetailView(index: index, router: self))
        case .featureA:
            let router = FeatureARouter(navigation: navigation)
            return AnyView(FeatureAView(router: router)
                .router(router)
            )
        default:
            return AnyView(EmptyView())
        }
    }
    
    override func alert(routing: MainRoutes, rootPresented: Binding<Bool>) -> Alert {
        if case let .alert(message) = routing {
            
            return Alert(title: Text("Main Alert"), message: Text(message))
        }
        return super.alert(routing: routing, rootPresented: rootPresented)
    }
}
