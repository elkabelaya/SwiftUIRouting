//
//  FeatureARouter.swift
//  SwiftUIRoutingSamples
//
//  Created by elka belaya  on 03.04.2026.
//

import SwiftUI
import SwiftUIRouting

enum FeatureARoutes: Hashable, Codable {
    case list
    case detail(Int)
    case alert
}

extension FeatureARoutes: Identifiable {
    var id: Self { self }
}

class FeatureARouter: Router<FeatureARoutes>{
    override func modal(routing: FeatureARoutes, rootPresented: Binding<Bool>) -> AnyView {
        switch routing {
        case .list:
            let router = FeatureARouter(isPresented: rootPresented)
            return AnyView(FeatureAListView(router: router)
                            .showCloseButton(true, action: router.dismiss)
                            .router(router)
                            .navigationStack(router.navigation)
            )
        case .detail(let index):
            let router = FeatureARouter(isPresented: rootPresented)
            return AnyView(FeatureADetailView(index: index, router: router)
                            .showCloseButton(true, action: router.dismiss)
                            .router(router)
                            .navigationStack(router.navigation)
            )
        default:
            return super.modal(routing: routing, rootPresented: rootPresented)
        }
    }
    
    override func navigation(routing: FeatureARoutes) -> AnyView {
        switch routing {
        case .list:
            return AnyView(FeatureAListView(router: self))
        case .detail(let index):
            return AnyView(FeatureADetailView(index: index, router: self))
        default:
            return super.navigation(routing: routing)
        }
    }
    
    override func alert(routing: FeatureARoutes, rootPresented: Binding<Bool>) -> Alert {
        Alert(title: Text("Feature A Alert"))
    }

}
