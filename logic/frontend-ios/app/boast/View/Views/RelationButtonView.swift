//
//  RelationButtonView.swift
//  boast
//
//  Created by Jannis Sideras on 26.02.24.
//

import SwiftUI

struct RelationButtonView: View {
    var targetId: Int
    var relationType: RelationStatus
    var body: some View {
        if UserDefaults().integer(forKey: "userId") != targetId {
            if relationType == .FRIEND {
                Button {
                    Task{
                        await unfollowUser(targetId: targetId)
                    }
                } label: {
                    Text("Unfollow")
                }
                .buttonStyle(.borderedProminent)
            }else if relationType == .NO_RELATION {
                Button {
                    Task{
                        await followUser(targetId: targetId)
                    }
                } label: {
                    Text("Follow")
                }
                .buttonStyle(.borderedProminent)
            }else if relationType == .REQUEST {
                Button {
                    Task{
                        await unfollowUser(targetId: targetId)
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
