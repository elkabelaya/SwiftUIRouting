//
//  Test.swift
//  SwiftUIRouting
//
//  Created by elka belaya  on 21.04.2026.
//

import SwiftUI
@testable import SwiftUIRouting
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
        AnyView(Text("Modal: $routing.title)" ))
    }

    override func navigation(routing: TestRouting) -> AnyView {
        AnyView(Text("Nav: $routing.title)" ))
    }

    override func alert(routing: TestRouting, rootPresented: Binding<Bool>) -> Alert {
        Alert(title: Text("Alert: $routing.title)" ))
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
