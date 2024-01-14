

import SwiftUI

struct Post: View {
    var postId: Int
    @State var data: PostModel?
    var body: some View {
        VStack {
            switch data?.type {
                case .TEXT:
                    let post = TextPostViewModel(model: data as! Text_PostModel)
                    TextPostView(post: post)
                case .POLL:
                    let post = PollPostViewModel(model: data as! Poll_PostModel)
                    PollPostView(post: post)
                default:
                    Text("loading...")
            }
        }
        .task {
            do {
                data = await loadPost(postId: postId)
            }
        }
    }
    
}

#Preview {
    Post(postId: 100)
}
