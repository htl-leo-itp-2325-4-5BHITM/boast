//
//  ContentView.swift
//  dummy
//
//  Created by Jannis Sideras on 19.03.24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            Feed()
                .tabItem {
                    Image(systemName: "house")
                }
            Create()
                .tabItem {
                    Image(systemName: "plus.app")
                }
            Search()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                }
            Profile()
                .tabItem {
                    Image(systemName: "person.circle")
                }
        }
    }
}

#Preview {
    ContentView()
}
