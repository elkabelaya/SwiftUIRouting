//
//  NavigationTests.swift
//  SwiftUIRouting
//
//  Created by elka belaya  on 21.04.2026.
//
import Testing
import SwiftUI
@testable import SwiftUIRouting

@MainActor @Suite struct NavigationTests {
    @Test func navigateToAddsRoute() async {
        //Given
        let router = TestRouter()
        #expect(router.navigation.path.count == 0)
        for index in 0...(TestsData.routes1.count - 1) {
            //When
            router.navigateTo(TestsData.routes1[index])
            
            //Then
            #expect(router.navigation.path.count == index + 1)
            #expect(router.navigation.comparables.count == index + 1)
            #expect(router.navigation.comparables.last??.rootId == TestsData.routes1[index].rootId)
        }
    }
    
    @Test func navigateBackRemovesLastRoute() async {
        //Given
        let router = TestRouter()
        router.navigateTo(TestsData.route1)
        router.navigateTo(TestsData.route2)
        
        //When
        router.navigateBack()
        
        //Then
        #expect(router.navigation.path.count == 1)
        #expect(router.navigation.comparables.count == 1)
        #expect(router.navigation.comparables.last??.rootId == TestsData.route1.rootId)
    }
    
    @Test func systemBackRemovesLastComparable() async {
        //Given
        let router = TestRouter()
        router.navigateTo(TestsData.route1)
        router.navigateTo(TestsData.route2)
        
        //When
        router.navigation.path.removeLast()
        
        //Then
        #expect(router.navigation.path.count == router.navigation.comparables.count )
        #expect(router.navigation.comparables.last??.rootId == TestsData.route1.rootId )
    }
    
    
    @Test func replaceNavigationOverwritesPath() async {
        //Given
        let router = TestRouter()
        router.navigateTo(TestsData.route1)
        
        //When
        router.replaceNavigation(TestsData.routes1)
        
        //Then
        #expect(router.navigation.path.count == TestsData.routes1.count )
        #expect(router.navigation.comparables.count == TestsData.routes1.count )
        #expect(router.navigation.comparables.first??.rootId != TestsData.route1.rootId )
        #expect(router.navigation.comparables.first??.rootId == TestsData.routes1.first?.rootId )
        #expect(router.navigation.comparables.last??.rootId == TestsData.routes1.last?.rootId )
    }
    
    @Test func navigateToSingleRemovesAllSames() async {
        //Given
        let router = TestRouter()
        let addCount = TestsData.sameRoutes.count - 1
        for index in 0...(addCount - 1) {
            router.navigateTo(TestsData.sameRoutes[index])
            if index < addCount - 1 {
                router.navigateTo(TestsData.route1)
            }
        }
        let added = addCount * 2 - 1
        #expect(router.navigation.path.count == added)
        #expect(router.navigation.comparables.count == added)
        let last = router.navigation.comparables.last as! TestRouting
        #expect(last.title == TestsData.sameRoutes[addCount - 1].title)
        
        //When
        router.navigateToSingle(TestsData.sameRoutes.last!)
        
        //Then
        #expect(router.navigation.path.count == 1)
        #expect(router.navigation.comparables.count == 1)
        let newLast = router.navigation.comparables.last as! TestRouting
        #expect(newLast.title == TestsData.sameRoutes.last!.title)
    }
    
    @Test func navigateToSingleTopReplacesLastIfSame() async {
        //Given
        let router = TestRouter()
        router.navigateTo(TestsData.sameRoutes.first!)
        router.navigateTo(TestsData.route1)
        router.navigateTo(TestsData.sameRoutes.first!)
        let count = router.navigation.path.count
        
        //When
        router.navigateToSingleTop(TestsData.sameRoutes.last!)
        
        //Then
        #expect(router.navigation.path.count == count )
        let last = router.navigation.comparables.last as! TestRouting
        #expect(last.title == TestsData.sameRoutes.last!.title )
    }
    
    @Test func dismissRemovesLastNavigation() async {
        //Given
        let router = TestRouter()
        router.navigateTo(TestsData.route1)
        router.navigateTo(TestsData.route2)
        
        //When
        router.dismiss()
        
        //Then
        #expect(router.navigation.path.count == 1 )
    }
    
    @Test func dismissRemovesLastNavigationForSingle() async {
        //Given
        let router = TestRouter()
        router.navigateToSingle(TestsData.route1)
        router.navigateToSingle(TestsData.route2)
        
        //When
        router.dismiss()
        
        //Then
        #expect(router.navigation.path.count == 1 )
    }
    
    @Test func dismissRemovesLastNavigationForSingleTop() async {
        //Given
        let router = TestRouter()
        router.navigateToSingleTop(TestsData.route1)
        router.navigateToSingleTop(TestsData.route2)
        
        //When
        router.dismiss()
        
        //Then
        #expect(router.navigation.path.count == 1 )
    }
    
    
}

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
//         #expect(router.presentingSheet.wrappedValue).to(beNil( )
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
