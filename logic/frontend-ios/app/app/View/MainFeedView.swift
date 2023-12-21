

import SwiftUI

struct MainFeedView: View {
    @State var postFeed = [Int]()
    var body: some View {
        NavigationView{
            ScrollView {
                Text("Main Feed")
                    .font(.largeTitle)
                
                ForEach(postFeed, id: \.self) { post in
                    Spacer(minLength: 30)
                    NavigationLink(destination: PostView(postId: post)) {
                        Post(postId: post)
                    }
                    .buttonStyle(.plain)
                    Spacer(minLength: 30)
                }
            }
            Spacer(minLength: 40)
        }
        .task {
            postFeed = await posts()
        }
    }
}

#Preview {
    MainFeedView()
}
