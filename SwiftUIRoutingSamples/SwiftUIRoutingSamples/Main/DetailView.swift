//
//  ContentView.swift
//  SwiftUIRoutingSamples
//
//  Created by elka belaya  on 07.04.2026.
//

import SwiftUI
import SwiftUIRouting

struct DetailView: View {
    
    private let index: Int
    @StateObject private var router: MainRouter
    
    init(index: Int, router: MainRouter) {
        self.index = index
        _router = StateObject(wrappedValue: router)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Detail deep : \(index)")
                .font(Font.largeTitle.weight(.bold))
            Button("Present Alert") {
                router.presentAlert(.alert("This is Detail Alert"))
            }
            Button("Navigate to Detail Again, Deep: \(index + 1)") {
                router.navigateTo(.detail(index + 1))
            }
            
            Button("Navigate to Detail As Single in Stack") {
                router.navigateToSingle(.detail(index + 1))
            }
            
            Button("Navigate to Detail As Single on Top") {
                router.navigateToSingleTop(.detail(index + 1))
            }
            
            Button("Navigate to Feature A") {
                router.navigateTo(.featureA)
            }
            
            Button("Replace Navigation Stack") {
                router.replaceNavigation([.featureA, .list])
            }
            
            Button("Pop to root") {
                router.popToRoot()
            }
            
            Button("Pop to initial") {
                router.popToRoot()
            }
            Button("Dismiss") {
                router.dismiss()
            }
            
        }
        .mainStyle()
    }
}

#Preview {
        DetailView(index: 1, router: MainRouter(isPresented: .constant(true)))
}
