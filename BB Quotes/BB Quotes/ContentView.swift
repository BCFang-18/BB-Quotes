//
//  ContentView.swift
//  BB Quotes
//
//  Created by Baicheng Fang on 5/1/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            QuoteView(show: Constants.bbN)
                .tabItem {
                    Label(Constants.bbN, systemImage: "tortoise")
                }
            
            QuoteView(show: Constants.bcsN)
                .tabItem {
                    Label(Constants.bcsN, systemImage: "briefcase")
                }
        }
        .onAppear {
            UITabBar.appearance().scrollEdgeAppearance = UITabBarAppearance()
        }
        .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    ContentView()
}
