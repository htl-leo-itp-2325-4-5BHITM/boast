

import SwiftUI

struct ContentView: View {
    @State private var posts = [Post]()
    var body: some View {
        VStack {
            ForEach(posts, id: \.id) { post in
                VStack {
                    Text(post.title)
                    Text(post.definition)
                    Text(post.creator)
                    Text(post.winner)
                    ForEach(post.postDetails, id: \.id) { details in
                        Text(details.bet + details.creator)
                    }
                }
            }

        }
        .task {
            posts = await getPostsAsList()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
