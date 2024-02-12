//
//  UserListView.swift
//  boast
//
//  Created by Jannis Sideras on 12.02.24.
//

import SwiftUI

struct UserListView: View {
    var userId: Int
    var relationType: String
    @State var userData = [Int]()
    @State var name = "error loading"
    var body: some View {
        NavigationStack {
            List{
                ForEach(userData, id: \.self) { userId in
                    NavigationLink(destination: UserProfileView(userId: userId)) {
                        UserPreviewView(userId: userId)
                    }
                }
            }
            .navigationTitle(relationType)
            .task {
                userData = await userList(userId: userId, userType: relationType) ?? [Int()]
            }
        }
    }
}
