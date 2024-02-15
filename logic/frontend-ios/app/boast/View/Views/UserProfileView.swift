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
                    Text(UserDefaults.standard.string(forKey: "userName") ?? userData?.username ?? "")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Button {
                        Task{
                            print("unlucky")
                        }
                    } label: {
                        Text("Follow")
                    }
                    .buttonStyle(.borderedProminent)
                    
                }
                .frame(width: UIScreen.main.bounds.width - 20, alignment: .leading)
                .padding()
                
                HStack {
                    NavigationLink(destination: UserListView(userId: userId, relationType: "following")) {
                        
                        Text("following: \(userData?.follower ?? 0)")
                    }
                    NavigationLink(destination: UserListView(userId: userId, relationType: "following")) {
                        Text("followers: \(userData?.following ?? 0)")
                    }
                    Text("posts: \(userData?.posts?.count ?? 0)")
                }
                
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
