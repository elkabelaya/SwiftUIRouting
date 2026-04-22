//
//  PopTests.swift
//  SwiftUIRouting
//
//  Created by elka belaya  on 21.04.2026.
//
import Testing
import SwiftUI
@testable import SwiftUIRouting

@MainActor @Suite struct PopTests {
    @Test func popToRootClearsAllPresentationsAndNavigation() async {
        //Given
        let router = TestRouter()
        router.navigateTo(TestsData.route1)
        router.navigateTo(TestsData.route2)
        router.presentSheet(TestsData.route1)
        
        //When
        router.popToRoot()
        
        //Then
        #expect(router.navigation.path.count == 0 )
        #expect(router.isPresentingSheet.wrappedValue == false)
    }
    
    @Test func popToInitialClearsAllCurrentDeepNavigations() async {
        //Given
        let router = TestRouter()
        router.navigateTo(TestsData.route1)
        router.navigateTo(TestsData.route2)
        let count = router.navigation.path.count
        let secondRouter = TestRouter(navigation: router.navigation)
        secondRouter.navigateTo(TestsData.route1)
        secondRouter.navigateTo(TestsData.route2)
        
        //When
        secondRouter.popToInitial()
        
        //Then
        #expect(router.navigation.path.count == count )
        #expect(secondRouter.navigation.path.count == count )
    }
    
    @Test func popToRootClearsAllDeepNavigation() async {
        //Given
        let router = TestRouter()
        router.navigateTo(TestsData.route1)
        router.navigateTo(TestsData.route2)
        let secondRouter = TestRouter(navigation: router.navigation)
        secondRouter.navigateTo(TestsData.route1)
        secondRouter.navigateTo(TestsData.route2)
        
        //When
        secondRouter.popToRoot()
        
        //Then
        #expect(router.navigation.path.count == 0 )
    }
}
