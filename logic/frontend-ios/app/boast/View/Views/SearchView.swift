//
//  SearchView.swift
//  boast
//
//  Created by Jannis Sideras on 12.02.24.
//

import SwiftUI

struct SearchView: View {
    @State private var searchText = ""
        @State private var searchIsActive = false
        var body: some View {
            VStack {
                NavigationStack {
                    Text("")
                        .navigationTitle("Find your friends")
                }
                .searchable(text: $searchText, isPresented: $searchIsActive)
                
                Button(action: {
                }, label: {
                    Text("Button")
                })
            }
        }
}

#Preview {
    SearchView()
}
