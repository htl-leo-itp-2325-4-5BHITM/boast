

import SwiftUI

struct MainFeedView: View {
    @State var postFeed = [Int]()
    var body: some View {
        NavigationView{
            ScrollView {
                Text("Main Feed")
                    .font(.largeTitle)
                
                ForEach(postFeed, id: \.self) { post in
                    NavigationLink(destination: PostView(postId: post)) {
                        Post(postId: post)
                    }
                }
            }
        }
        .task {
            postFeed = await posts()
        }
    }
}

#Preview {
    MainFeedView()
}
