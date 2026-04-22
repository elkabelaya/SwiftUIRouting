//
//  AlertUITests.swift
//  SwiftUIRouting
//
//  Created by elka belaya  on 22.04.2026.
//

import XCTest

final class AlertUITests: SwiftUIRoutingTestCase {

    func testPresentAlert() {
        //Given
        let page = TestPage(app: app)

        //When
        page.tapAlert()
        
        //Then
        XCTAssertTrue(page.isAlertPresented(1))
    }
    
    func testClickAlert() {
        //Given
        let page = TestPage(app: app)
        page.tapAlert()
        
        //When
        page.tapAlertButton()
        
        //Then
        XCTAssertTrue(page.isInRoot())
    }
}
