

import SwiftUI

var post: PostModel?

struct PostsView: View {
    var body: some View {
        VStack {
            
            
            Text(post?.createdOn ?? "")
            
        }.task {
            post = await loadPost()
            print(post?.createdOn)
        }
        
    }
}

#Preview {
    PostsView()
}
