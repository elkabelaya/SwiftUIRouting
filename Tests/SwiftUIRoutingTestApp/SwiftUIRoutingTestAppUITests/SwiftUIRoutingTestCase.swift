//
//  SwiftUIRoutingTestCase.swift
//  SwiftUIRoutingTestApp
//
//  Created by elka belaya  on 22.04.2026.
//
import XCTest
@testable import SwiftUIRoutingTestApp

@MainActor class SwiftUIRoutingTestCase: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUp() async throws {
        try  await super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    override func tearDown() async throws {
        app = nil
        try await super.tearDown()
    }
    
}
