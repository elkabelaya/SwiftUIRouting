//
//  TestViewData.swift
//  SwiftUIRoutingTestApp
//
//  Created by elka belaya  on 22.04.2026.
//

struct TestViewData {
    struct Buttons {
        static let navigate1: String = "Navigate to 1"
        static let navigate2: String = "Navigate 2"
        static let navigateSame: String = "Navigate To Same"
        static let showSheet: String = "Show Sheet"
        static let showFull: String = "Show Full"
        static let alert: String = "Alert"
        static let dismiss: String = "Dismiss"
        static let alertOk: String = "Ok"
        static let alertCancel: String = "Cancel"
    }
    
    struct Types {
        static let root: String = "Type Root"
        static func navigate(_ id: Int)-> String {
            "Type Navigate \(id)"
        }
        static func modal(_ id: Int)-> String {
            "Type Modal \(id)"
        }
        static func alert(_ id: Int)-> String {
            "Type Alert \(id)"
        }
    }
    
    struct Identifiers {
        static let modal: String = "Modal"
    }
}
