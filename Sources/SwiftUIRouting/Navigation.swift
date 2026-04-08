//
//  Navigation.swift
//  SwiftUIRouting
//
//  Created by elka belaya  on 07.04.2026.
//

import SwiftUI
import Combine

@MainActor public final class Navigation: ObservableObject {
    @Published internal var path: NavigationPath = NavigationPath()
    fileprivate var comparables: [(any RouteComparable)?] = []
    private var cancellable: AnyCancellable?
    
    public init() {
        cancellable = $path.sink { [weak self] newValue in
            guard let self else { return }
            if newValue.count < comparables.count {
                comparables = Array(comparables.prefix(newValue.count))
            }
        }
        
    }
    
    private init(path: NavigationPath, comparables: [(any RouteComparable)?]) {
        self.comparables = comparables
        self.path = path
    }
    
    func copy() -> Navigation {
        Navigation(path: path, comparables: comparables)
    }
    
    func append(_ route: any Routable) {
        let comparable = route as? any RouteComparable
        comparables.append(comparable)
        path.append(route)
    }
    
    func appendPath(_ routes: [any Routable]) {
        routes.forEach(append)
    }
    
    func removeLast() {
        if comparables.count > 0 {
            comparables.removeLast()
            path.removeLast()
            
        }
    }
    
    func replace(_ routes: [any Routable]) {
        self.reset()
        routes.forEach(self.append)
    }
    
    func replace(_ navigation: Navigation) {
        comparables = navigation.comparables
        path = navigation.path
    }
    
    func reset() {
        comparables = []
        path = .init()
    }
    
    func replaceSingle(_ route: any RouteComparable, with initial: Navigation) {
        let initialComparables: [(any RouteComparable)?] = initial.comparables
        for index in (max(initialComparables.count - 1, 0)..<comparables.count - 1) {
            if let comparable: any RouteComparable = comparables[index],
               let comparableId = comparable.rootId,
                comparableId == route.rootId {
                let countToRemove = comparables.count - index
                comparables = Array(comparables.prefix(index))
                self.path.removeLast(countToRemove)
                
                break
            }
        }
        
        append(route)
    }
    
    func topSingle(_ route: any RouteComparable) {
        if let comparable: (any RouteComparable) = comparables.last as? (any RouteComparable),
           let comparableId = comparable.rootId,
            comparableId == route.rootId {
            comparables = Array(comparables.prefix(comparables.count - 1))
            self.path.removeLast()
        }
        
        append(route)
    }
    
    func replaceTop(_ route: any Routable) {
        removeLast()
        append(route)
    }
}
