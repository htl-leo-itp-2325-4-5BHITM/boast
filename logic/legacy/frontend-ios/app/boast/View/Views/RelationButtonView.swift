//
//  RelationButtonView.swift
//  boast
//
//  Created by Jannis Sideras on 26.02.24.
//

import SwiftUI

struct RelationButtonView: View {
    var targetId: Int
    @State var relationType: RelationStatus?
    var body: some View {
        if UserDefaults().integer(forKey: "userId") != targetId {
            if relationType == .FRIEND {
                Button {
                    Task{
                        relationType = await unfollowUser(targetId: targetId) ?? .NO_RELATION
                    }
                } label: {
                    Text("Unfollow")
                }
                .buttonStyle(.borderedProminent)
            }else if relationType == .NO_RELATION {
                Button {
                    Task{
                        relationType = await followUser(targetId: targetId) ?? .NO_RELATION
                    }
                } label: {
                    Text("Follow")
                }
                .buttonStyle(.borderedProminent)
            }else if relationType == .REQUEST {
                Button {
                    Task{
                        relationType = await unfollowUser(targetId: targetId) ?? .NO_RELATION
                    }
                } label: {
                    Text("Requested")
                }
                .buttonStyle(.borderedProminent)
            }else {
                Button {
                    Task{
                        print("unlucky")
                    }
                } label: {
                    Text("Not implemented yet")
                }
                .buttonStyle(.borderedProminent)
            }
        }
        
    }
}

#Preview {
    RelationButtonView(targetId: 102, relationType: .FRIEND)
}
