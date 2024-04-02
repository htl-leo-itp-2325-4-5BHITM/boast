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
                    Image(systemName: "person.circle")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 50)
                    VStack(alignment: .leading) {
                        Text(userData?.username ?? "")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        Text("@\(userData?.username ?? "")")
                            .font(.callout)
                    }
                    if userData != nil {
                        RelationButtonView(targetId: userData?.userId ?? -1, relationType: userData?.relationStatus)
                    }
                }
                .frame(width: UIScreen.main.bounds.width - 20, alignment: .leading)
                .padding()
                
                
                HStack {
                    NavigationLink(destination: UserListView(userId: userData?.userId ?? -1, relationType: "following")) {
                        Text("following: \(userData?.following ?? 0)")
                    }
                    NavigationLink(destination: UserListView(userId: userData?.userId ?? -1, relationType: "followers")) {
                        Text("followers: \(userData?.follower ?? 0)")
                    }
                    Text("Posts: \(userData?.posts?.count ?? 0)")
                }
                
                Divider()
                    .frame(height: 0.5)
                    .overlay(.blackAndWhite)

                Spacer()
                
                ScrollView {
                    ForEach(userData?.posts ?? [-1], id:\.self) { postId in
                        if postId != -1 {
                            NavigationLink(destination: Post(postId: postId)) {
                                PostPreview(postId: postId)
                            }
                            .buttonStyle(.plain)
                            Spacer(minLength: 30)
                        }
                    }
                }
            }
            
        }
        .task {
            userData = await userInfo(userId: userId)
        }
    }
}

#Preview {
    UserProfileView(userId: 102)
}
