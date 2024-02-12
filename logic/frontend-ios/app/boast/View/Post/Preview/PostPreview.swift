

import SwiftUI

struct PostPreview: View {
    var postId: Int
    @State var data: PostModel?
    var body: some View {
        VStack {
            switch data?.type {
                case .TEXT:
                    TextPostPreview(post: data as? Text_PostModel)
                case .POLL:
                    PollPostPreview(post: data as? Poll_PostModel)
                default:
                    Text("loading...")
            }
        }
        .task {
            data = await loadPost(postId: postId)
        }
    }
}

#Preview {
    PostPreview(postId: 1)
}
