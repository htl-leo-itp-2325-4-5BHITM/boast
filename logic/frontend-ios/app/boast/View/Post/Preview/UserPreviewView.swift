//
//  UserPreviewView.swift
//  boast
//
//  Created by Jannis Sideras on 12.02.24.
//

import SwiftUI

struct UserPreviewView: View {
    var userId: Int
    @State var user: PreviewModel?
    var body: some View {
        VStack {
            Text(user?.username ?? "loading... ")
        }
        .task {
            user = await userPreview(userId: userId)
        }
    }
}

#Preview {
    UserPreviewView(userId: 100)
}
