//
//  NavigationUITests.swift
//  SwiftUIRouting
//
//  Created by elka belaya  on 22.04.2026.
//

import XCTest
final class NavigationUITests: SwiftUIRoutingTestCase {

    func testNavigation() {
        //Given
        let page = TestPage(app: app)

        //When
        page.tapNavigate1()
        
        //Then
        XCTAssertTrue(page.isNavigatedTo(1))
    }
    
    func testBackFromNavigation() {
        //Given
        let page = TestPage(app: app)
        page.tapNavigate1()

        //When
        page.tapBack()
        
        //Then
        XCTAssertTrue(page.isInRoot())
    }
    
    func testSwipeBackFromNavigation() {
        //Given
        let page = TestPage(app: app)
        page.tapNavigate1()

        //When
        page.swipeBack()
        
        //Then
        XCTAssertTrue(page.isInRoot())
    }
    
    func testDismissFromNavigation() {
        //Given
        let page = TestPage(app: app)
        page.tapNavigate1()

        //When
        page.tapDismiss()
        
        //Then
        XCTAssertTrue(page.isInRoot())
    }
}
