

import SwiftUI



struct MainFeedView: View {
    @State var postFeed = [Int]()
    @ObservedObject var viewModel: PostViewModel
    var body: some View {
        NavigationView{
            ScrollView {
                Text("Main Feed")
                    .font(.largeTitle)
                ForEach(postFeed, id: \.self) { post in
                    NavigationLink(destination: Post(postId: post)) {
                        PostPreview(postId: post)
                    }
                    .buttonStyle(.plain)
                    Spacer(minLength: 30)
                }
            }
            Spacer(minLength: 40)
        }
        .refreshable {
            postFeed = await posts()
        }
        .task{
            do {
                postFeed = await posts()
            }
        }
    }
}

#Preview {
    MainFeedView(viewModel: PostViewModel(model: PostModel()))
}
