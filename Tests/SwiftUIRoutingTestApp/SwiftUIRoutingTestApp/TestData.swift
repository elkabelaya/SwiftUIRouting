//
//  Test.swift
//  SwiftUIRouting
//
//  Created by elka belaya  on 21.04.2026.
//

import SwiftUI
import SwiftUIRouting

enum TestRouting: RouteComparable {
    var rootId: AnyHashable? {
        if case let .page(index, _) = self {
            return index
        }
        return nil
    }
    var title: String? {
        if case let .page(_, title) = self {
            return title
        }
        return nil
    }
    var id: Self { self }
    case page(Int, String? = nil)
    case alert(Int, String? = nil)
}


final class TestRouter: Router<TestRouting> {
    override func modal(routing: TestRouting, rootPresented: Binding<Bool>) -> AnyView {
        if case let .page(id, title) = routing {
            let router = TestRouter(isPresented: rootPresented)
            return AnyView(
                TestView(type: TestViewData.Types.modal(id),
                         navigatedSameRootId: routing.rootId,
                         router: router)
                .router(router)
                .navigationStack(router.navigation)
                .accessibilityIdentifier(TestViewData.Identifiers.modal)
            )
        }
        return AnyView(EmptyView())
    }

    override func navigation(routing: TestRouting) -> AnyView {
        if case let .page(id, title) = routing {
            return AnyView(
                TestView(type: TestViewData.Types.navigate(id),
                         navigatedSameRootId: routing.rootId,
                         router: self)
            )
        }
        return AnyView(EmptyView())
    }

    override func alert(routing: TestRouting, rootPresented: Binding<Bool>) -> Alert {
        if case let .alert(id, title) = routing {
            return Alert(title: Text(TestViewData.Types.alert(id)))
        }
        return Alert(title: Text("Something Wrong"))
    }
}

struct ContentView: View {
    @StateObject var router = TestRouter()
    
    var body: some View {
        TestView(type: TestViewData.Types.root,
                 navigatedSameRootId: nil,
                 router: router)
        .router(router)
        .navigationStack(router.navigation)
    }
}

struct TestView: View {
    let type: String
    let navigatedSameRootId: AnyHashable?
    var router: TestRouter

    var body: some View {
        VStack(spacing: 20) {
            Text(type)
            
            if let navigatedSameRootId {
                Text("SameRootId \(navigatedSameRootId)")
            }
            
            Button(TestViewData.Buttons.navigate1) {
                router.navigateTo(TestsData.route1)
            }
            
            Button(TestViewData.Buttons.navigate2) {
                router.navigateTo(TestsData.route1)
            }
            
            Button(TestViewData.Buttons.navigateSame) {
                router.navigateTo(TestsData.route1)
            }
            
            Button(TestViewData.Buttons.showSheet) {
                router.presentSheet(TestsData.route1)
            }
            
            Button(TestViewData.Buttons.showFull) {
                router.presentFullScreenCover(TestsData.route1)
            }
            
            Button(TestViewData.Buttons.alert) {
                router.presentAlert(TestsData.alert)
            }
            
            Button(TestViewData.Buttons.dismiss) {
                router.dismiss()
            }
        }
    }
}

struct TestsData {
    static let route1: TestRouting = TestRouting.page(1)
    static let route2: TestRouting = TestRouting.page(2)
    static let routes1: [TestRouting] = [TestRouting.page(3), TestRouting.page(4)]
    static let sameRoutes: [TestRouting] = [
        TestRouting.page(5,"1"),
        TestRouting.page(5,"2"),
        TestRouting.page(5,"3"),
        TestRouting.page(5,"4")
    ]
    static let alert: TestRouting = TestRouting.alert(1, "Alert")
}
