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
    @State var userData: [PreviewModel]?
    var body: some View {
        VStack {
            NavigationStack {
                Text("")
                    .navigationTitle("Find your friends")
                List {
                    ForEach(userData ?? [PreviewModel](), id: \.userId) { user in
                        NavigationLink(destination: UserProfileView(userId: user.userId ?? 0)) {
                            UserPreviewView(userId: user.userId ?? 0)
                        }
                    }
                }
            }
            .searchable(text: $searchText, isPresented: $searchIsActive)
        }
        .onChange(of: searchText, {
            Task {
                userData = await searchForUsers(searchText: searchText)
            }
        })
    }
}

#Preview {
    SearchView()
}
