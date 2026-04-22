//
//  AlertTests.swift
//  SwiftUIRouting
//
//  Created by elka belaya  on 21.04.2026.
//
import Testing
import SwiftUI
@testable import SwiftUIRouting

@MainActor @Suite struct AlertTests {
    @Test func presentAlertSetsState() async {
        //Given
        let router = TestRouter()
        #expect(router.presentingAlert.wrappedValue  == nil)
        
        //When
        router.presentAlert(TestsData.alert)
        
        //Then
        #expect(router.presentingAlert.wrappedValue == TestsData.alert)
        #expect(router.isPresentingAlert.wrappedValue == true)
    }
    
    @Test func dismissClosesAlert() async {
        //Given
        let router = TestRouter()
        router.presentAlert(TestsData.alert)
        
        //When
        router.dismiss()
        
        //Then
        #expect(router.isPresentingAlert.wrappedValue == false)
    }
}
