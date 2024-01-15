

import SwiftUI

struct Post: View {
    var postId: Int
    @State var data: PostModel?
    var body: some View {
        VStack {
            switch data?.type {
                case .TEXT:
                    var post = TextPostViewModel(model: data as! Text_PostModel)
                    TextPostView(post: post)
                case .POLL:
                    var post = PollPostViewModel(model: data as! Poll_PostModel)
                    PollPostView(post: post)
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
    Post(postId: 110)
}
