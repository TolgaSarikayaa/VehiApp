//
//  ContentView.swift
//  MyCar
//
//  Created by Tolga Sarikaya on 14.03.24.
//

import SwiftUI

struct ContentView: View {
    
    
    @State private var currentTab = 0
    
    var body: some View {
        NavigationStack {
            TabView(selection: $currentTab,
                    content:  {
                ForEach(OnboardingData.list) { viewData in
                    OnboardingView(data: viewData)
                        .tag(viewData.id)
                    
                }
            })
            .tabViewStyle(PageTabViewStyle())
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
        }
    }
}

#Preview {
    ContentView()
}
