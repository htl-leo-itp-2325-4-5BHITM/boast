

import SwiftUI

struct PostView: View {
    let postId: Int
    var body: some View {
        ScrollView {
            Post(postId: postId)
        }
    }
}

#Preview {
    PostView(postId: 101)
}

