

import SwiftUI

struct PostView: View {
    let postId: Int
    var body: some View {
        VStack {
            Post(postId: postId)
        }
    }
}

#Preview {
    PostView(postId: 101)
}

