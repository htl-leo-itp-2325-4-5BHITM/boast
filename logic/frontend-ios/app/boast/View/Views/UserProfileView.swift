//
//  UserProfileView.swift
//  boast
//
//  Created by Jannis Sideras on 12.02.24.
//

import SwiftUI

struct UserProfileView: View {
    var userId: Int
    @State var userData: ProfileModel? = nil
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    NavigationLink(destination: UserListView(userId: userId, relationType: "friends")) {
                        Text("friends: \(userData?.friends ?? 0)")
                    }
                    NavigationLink(destination: UserListView(userId: userId, relationType: "follows")) {
                        Text("follows: \(userData?.follows ?? 0)")
                    }
                    Text("posts: \(userData?.posts?.count ?? 0)")
                }
                
                Spacer()
                
                ScrollView {
                    ForEach(userData?.posts ?? [0], id:\.self) { postId in
                        NavigationLink(destination: Post(postId: postId)) {
                            PostPreview(postId: postId)
                        }
                        .buttonStyle(.plain)
                        Spacer(minLength: 30)
                    }
                }
            }
            .navigationTitle(userData?.username ?? "")
            .toolbarTitleDisplayMode(.inlineLarge)
            
        }
        .task {
            userData = await userInfo(userId: userId)
        }
    }
}

#Preview {
    UserProfileView(userId: 100)
}
