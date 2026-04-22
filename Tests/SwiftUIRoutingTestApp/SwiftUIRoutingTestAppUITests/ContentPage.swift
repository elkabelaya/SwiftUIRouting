//
//  ContentPage.swift
//  SwiftUIRouting
//
//  Created by elka belaya  on 22.04.2026.
//

import XCTest

@MainActor struct TestPage {
    private let app: XCUIApplication
    
    private var rootTitle: XCUIElement {
        wait(app.staticTexts[TestViewData.Types.root])
    }
    private var navigate1Button: XCUIElement {
        wait(app.buttons[TestViewData.Buttons.navigate1])
    }
    
    private var sheetButton: XCUIElement {
        wait(app.buttons[TestViewData.Buttons.showSheet])
    }
    
    private var fullButton: XCUIElement {
        wait(app.buttons[TestViewData.Buttons.showFull])
    }
    
    private var alertButton: XCUIElement {
        wait(app.buttons[TestViewData.Buttons.alert])
    }
    
    private var closeButton: XCUIElement {
        wait(app.navigationBars.buttons.matching(identifier: "BackButton").firstMatch)
    }
    
    private var modalView: XCUIElement {
        wait(app.otherElements[TestViewData.Identifiers.modal])
    }
    
    private var alertView: XCUIElement {
        wait(app.alerts.element)
    }
    
    private var windowSize: CGSize {
        sizeOf(app.windows.element)
    }
    
    init(app: XCUIApplication) { self.app = app }
    
    private func wait(_ element: XCUIElement) -> XCUIElement {
        _ = element.waitForExistence(timeout: 2)
        return element
    }
    
    private func dismissButton(in element: XCUIElement) -> XCUIElement {
        wait(element.buttons[TestViewData.Buttons.dismiss])
    }
    
    private func title(_ id: Int) -> XCUIElement {
        title(TestViewData.Types.navigate(id), in: app)
    }
    
    private func modalTitle(_ id: Int, in element: XCUIElement) -> XCUIElement {
        title(TestViewData.Types.modal(id), in: element)
    }
    
    private func alertTitle(_ id: Int, in element: XCUIElement) -> XCUIElement {
        title(TestViewData.Types.alert(id), in: element)
    }
    
    private func title(_ title: String, in element: XCUIElement) -> XCUIElement {
        wait(element.staticTexts[title])
    }
    
    private func sizeOf(_ element: XCUIElement) -> CGSize {
        wait(element).frame.size
    }

    func tapNavigate1() { navigate1Button.tap()}
    func tapBack() { closeButton.tap() }
    func swipeBack() { app.swipeRight() }
    func tapDismiss() { dismissButton(in: app).tap() }
    
    func tapSheet() { sheetButton.tap() }
    func tapFull() { fullButton.tap() }
    func tapDismissInModal() { dismissButton(in: modalView).tap() }
    func tapAlertButton() { alertView.buttons.firstMatch.tap() }
    func swipeDownSheet() {
        let startCoord = modalView.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.1))
        let endCoord = modalView.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.9))
        startCoord.press(forDuration: 0.05,
                         thenDragTo: endCoord,
                         withVelocity: .fast,
                         thenHoldForDuration: 0.1)
    }
    
    func tapAlert() { alertButton.tap() }
    
    func isNavigatedTo(_ id: Int) -> Bool {
        return title(id).exists && closeButton.exists
    }
    
    func isInRoot() -> Bool { rootTitle.exists && rootTitle.isHittable }
    
    func isSheetPresented(_ id: Int) -> Bool {
        let size = sizeOf(modalView)
        return modalView.exists  && modalView.isHittable
        && modalTitle(id, in: modalView).exists
        && size.width == windowSize.width
        && size.height < windowSize.height
    }
    
    func isFullPresented(_ id: Int) -> Bool {
        let size = sizeOf(modalView)
        return modalView.exists && modalView.isHittable
        && modalTitle(id, in: modalView).exists
        && size.width == windowSize.width
        && size.height == windowSize.height
    }
    
    func isAlertPresented(_ id: Int) -> Bool {
        return alertView.exists && alertView.isHittable
        && alertTitle(id, in: alertView).exists
    }
}
