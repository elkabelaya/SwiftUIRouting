//
//  ContentView.swift
//  SwiftUIRoutingSamples
//
//  Created by elka belaya  on 07.04.2026.
//

import SwiftUI
import SwiftUIRouting

struct MainView: View {
    
    @StateObject private var router: MainRouter
    
    init(router: MainRouter) {
        _router = StateObject(wrappedValue: router)
    }
    
    var body: some View {
        VStack (alignment: .leading, spacing: 24) {
            Button("Present List in Sheet") {
                router.presentSheet(.list)
            }
            Button("Present List in FullCover") {
                router.presentFullScreenCover(.list)
            }
            Button("Navigate to List") {
                router.navigateTo(.list)
            }
            
            Button("Present Detail in Sheet") {
                router.presentSheet(.detail(1))
            }
            
            Button("Present Detail in FullCover") {
                router.presentFullScreenCover(.detail(1))
            }
            
            Button("Navigate to Detail") {
                router.navigateTo(.detail(1))
            }
            
            Button("Show Alert") {
                router.presentAlert(.alert("This is an alert"))
            }
            
            Button("Present FeatureA in Sheet") {
                router.presentSheet(.featureA)
            }
            Button("Present FeatureA in FullCover") {
                router.presentFullScreenCover(.featureA)
            }
            Button("Navigate to FeatureA") {
                router.navigateTo(.featureA)
            }
        }
        .mainStyle()
        .router(router)
        .navigationStack(router.navigation)
    }
}

struct MainView_Previews: PreviewProvider {
    
    static var previews: some View {
        MainView(router: MainRouter(isPresented: .constant(true)))
    }
}
