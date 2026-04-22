//
//  ModalTests.swift
//  SwiftUIRouting
//
//  Created by elka belaya  on 21.04.2026.
//
import Testing
import SwiftUI
@testable import SwiftUIRouting

@MainActor @Suite struct ModalTests {
    @Test func presentSheetSetsState() async {
        //Given
        let router = TestRouter()
        #expect(router.presentingSheet.wrappedValue == nil)
        
        //When
        router.presentSheet(TestsData.route1)
        
        //Then
        #expect(router.isPresentingSheet.wrappedValue == true)
        #expect(router.presentingSheet.wrappedValue == TestsData.route1 )
    }
    
    @Test func dismissClosesSheet() async {
        //Given
        let router = TestRouter()
        router.presentSheet(TestsData.route1)
        
        //When
        router.dismiss()
        
        //Then
        #expect(router.isPresentingSheet.wrappedValue == false)
    }
    
    @Test func presentFullScreenCoverSetsState() async {
        //Given
        let router = TestRouter()
        #expect(router.presentingFullScreenCover.wrappedValue  == nil)
        
        //When
        router.presentFullScreenCover(TestsData.route1)
        
        //Then
        #expect(router.isPresentingFullScreenCover.wrappedValue == true)
        #expect(router.presentingFullScreenCover.wrappedValue == TestsData.route1 )
    }
    
    @Test func dismissClosesFullScreenCover() async {
        //Given
        let router = TestRouter()
        router.presentFullScreenCover(TestsData.route1)
        
        //When
        router.dismiss()
        
        //Then
        #expect(router.isPresentingFullScreenCover.wrappedValue == false)
    }
    
}


//

//
//    // ---------- Pop to root / initial ----------
//    @Test func popToRootClearsAllPresentationsAndNavigation() async {
//        let router = TestRouter()
//        router.navigateTo(TestRouting(title: "First" )
//        router.presentSheet(TestRouting(title: "Sheet" )
//
//         #expect(router.navigation.path.count == 1 )
//         #expect(router.presentingSheet.wrappedValue).notTo(beNil( )
//
//        router.popToRoot()
//
//         #expect(router.navigation.path.count == 0 )
//         #expect(router.presentingSheet.wrappedValue  == nil)
//    }
//
//    @Test func popToInitialRestoresInitialNavigation() async {
//        let router = TestRouter()
//        router.navigateTo(TestRouting(title: "First" )
//        router.replaceNavigation(Navigation( ) // clear
//
//         #expect(router.navigation.path.count == 0 )
//
//        router.popToInitial()
//
//        // initialNavigation хранится в `initialNavigation` и имеет 1 элемент (по умолчанию)
//         #expect(router.navigation.path.count == 1 )
//    }
//}
//
