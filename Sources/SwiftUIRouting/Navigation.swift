//
//  Navigation.swift
//  SwiftUIRouting
//
//  Created by elka belaya  on 07.04.2026.
//

import SwiftUI

public final class Navigation: ObservableObject {
    @Published internal var path: NavigationPath = NavigationPath()
    fileprivate var comparables: [(any RouteComparable)?] = []
    
    public init() {
    }
    
    private init(path: NavigationPath, comparables: [(any RouteComparable)?]) {
        self.path = path
        self.comparables = comparables
    }
    
    func copy() -> Navigation {
        Navigation(path: path, comparables: comparables)
    }
    
    func append(_ route: any Routable) {
        path.append(route)
        let comparable = route as? any RouteComparable
        comparables.append(comparable)
    }
    
    func removeLast() {
        if comparables.count > 0 {
            path.removeLast()
            comparables.removeLast()
        }
    }
    
    func replace(_ newNavigation: Navigation) {
        path = newNavigation.path
        comparables = newNavigation.comparables
    }
    
    func reset() {
        path = .init()
        comparables = []
    }
    
    func replaceSingle(_ route: any RouteComparable, with initial: Navigation) {
        let initialComparables: [(any RouteComparable)?] = initial.comparables
        for index in (max(initialComparables.count - 1, 0)..<comparables.count - 1) {
            if let comparable: any RouteComparable = comparables[index],
               let comparableId = comparable.rootId,
                comparableId == route.rootId {
                path.removeLast(comparables.count - index)
                comparables = Array(comparables.prefix(index + 1))
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
            path.removeLast()
        }
        
        append(route)
    }
}
