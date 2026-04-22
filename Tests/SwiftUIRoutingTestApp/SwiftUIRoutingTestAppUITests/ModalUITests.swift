//
//  ModalUITests.swift
//  SwiftUIRouting
//
//  Created by elka belaya  on 22.04.2026.
//

import XCTest

final class ModalUITests: SwiftUIRoutingTestCase {

    func testPresentSheet() {
        //Given
        let page = TestPage(app: app)

        //When
        page.tapSheet()
        
        //Then
        XCTAssertTrue(page.isSheetPresented(1))
    }
    
    func testDismissSheet() {
        //Given
        let page = TestPage(app: app)
        page.tapSheet()
        
        //When
        page.tapDismissInModal()
        
        //Then
        XCTAssertTrue(page.isInRoot())
    }
    
    func testSwipeDownSheet() {
        //Given
        let page = TestPage(app: app)
        page.tapSheet()
        
        //When
        page.swipeDownSheet()
        
        //Then
        XCTAssertTrue(page.isInRoot())
    }
    
    func testPresentFull() {
        //Given
        let page = TestPage(app: app)

        //When
        page.tapFull()
        
        //Then
        XCTAssertTrue(page.isFullPresented(1))
    }
    
    func testDismissFull() {
        //Given
        let page = TestPage(app: app)
        page.tapFull()
        
        //When
        page.tapDismissInModal()
        
        //Then
        XCTAssertTrue(page.isInRoot())
    }
}
