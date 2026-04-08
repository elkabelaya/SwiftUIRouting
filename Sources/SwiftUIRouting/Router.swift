//
//  Router.swift
//  SwiftUIRouting
//
//  Created by elka belaya  on 03.04.2026.
//

import SwiftUI

public typealias Routable = Hashable & Identifiable & Codable

public protocol RouteComparable: Routable {
    var rootId: AnyHashable? { get }
}

@MainActor
open class Router<Routing: Routable>: ObservableObject {
    
    struct State {
        var presentingSheet: (Routing)? = nil
        var presentingFullScreenCover: (Routing)? = nil
        var presentingAlert: (Routing)? = nil
        var isPresented: Binding<Bool>?
    }
 
    @Published private(set) var state: State
    public var navigation: Navigation
    private var initialNavigation: Navigation

    
    public init (navigation: Navigation = .init(), isPresented: Binding<Bool>? = nil) {
        self.navigation = navigation
        initialNavigation = navigation.copy()
        state = State(isPresented: isPresented)
    }
    
    open func modal(routing: Routing, rootPresented: Binding<Bool>) -> AnyView {
        fatalError("must be implemented in inheriters")
    }
    
    open func navigation(routing: Routing) -> AnyView {
        fatalError("must be implemented in inheriters")
    }
    
    open func alert(routing: Routing, rootPresented: Binding<Bool>) -> Alert {
        fatalError("must be implemented in inheriters")
    }
}

public extension Router {
    func navigateTo(_ routing: Routing) {
        navigation.append(routing)
    }
    
    func navigateToSingle(_ routing: Routing) {
        guard let comparable =  routing as? (any RouteComparable),
        let _ = comparable.rootId else {
            fatalError("Item must be RouteComparable with rootId")
        }
        navigation.replaceSingle(comparable, with: initialNavigation)
    }
    
    func navigateToSingleTop(_ routing: Routing) {
        guard let comparable =  routing as? (any RouteComparable) else {
            fatalError("Item must be RouteComparable with rootId")
        }
        navigation.topSingle(comparable)
    }
    
    func navigateBack() {
        navigation.removeLast()
    }
    
    func replaceNavigation(_ navigation: Navigation) {
        self.navigation.replace(navigation)
    }
    
    func presentSheet(_ routing: Routing) {
        state.presentingSheet = routing
    }
    
    func presentFullScreenCover(_ routing: Routing) {
        state.presentingFullScreenCover = routing
    }
    
    func presentAlert(_ routing: Routing) {
        state.presentingAlert = routing
    }
    
    func dismiss() {
        if state.presentingSheet != nil {
            state.presentingSheet = nil
        } else if state.presentingFullScreenCover != nil {
            state.presentingFullScreenCover = nil
        } else if state.presentingAlert != nil {
            state.presentingAlert = nil
        } else if state.isPresented != nil {
            state.isPresented?.wrappedValue = false
        } else if navigation.path.count > 1 {
            navigation.removeLast()
        }
    }
    
    func popToRoot() {
        state.presentingAlert = nil
        state.presentingFullScreenCover = nil
        state.presentingSheet = nil
        navigation.reset()
    }
    
    func popToInitial() {
        state.presentingAlert = nil
        state.presentingFullScreenCover = nil
        state.presentingSheet = nil
        navigation.replace(initialNavigation)
    }
}

extension Router {
    var presentingSheet: Binding<(Routing)?> {
        binding(keyPath: \.presentingSheet)
    }
    
    var presentingFullScreenCover: Binding<(Routing)?> {
        binding(keyPath: \.presentingFullScreenCover)
    }
    
    var presentingAlert: Binding<(Routing)?> {
        binding(keyPath: \.presentingAlert)
    }
}

extension Router {
    var isPresentingSheet: Binding<Bool> {
        boolBinding(keyPath: \.presentingSheet)
    }
    
    var isPresentingFullScreenCover: Binding<Bool> {
        boolBinding(keyPath: \.presentingFullScreenCover)
    }
   
    var isPresentingAlert: Binding<Bool> {
        boolBinding(keyPath: \.presentingAlert)
    }
    
    var isPresented: Binding<Bool> {
        boolBinding(keyPath: \.isPresented)
    }
}

private extension Router {
    func binding<T>(keyPath: WritableKeyPath<State, T>) -> Binding<T> {
        Binding(
            get: { self.state[keyPath: keyPath] },
            set: { self.state[keyPath: keyPath] = $0 }
        )
    }
    
    func boolBinding<T>(keyPath: WritableKeyPath<State, T?>) -> Binding<Bool> {
        Binding(
            get: { self.state[keyPath: keyPath] != nil },
            set: {
                if !$0 {
                    self.state[keyPath: keyPath] = nil
                }
            }
        )
    }

}
