
import SwiftUI

struct MainFeedView: View {
    @State var postFeed = [Int]()
    @ObservedObject var viewModel: PostViewModel
    @State var feedBool: Bool = true
    var body: some View {
        NavigationStack{
            VStack {
                Spacer(minLength: 20)
                ScrollView {
                    ForEach(postFeed, id: \.self) { post in
                        NavigationLink(destination: Post(postId: post)) {
                            PostPreview(postId: post)
                        }
                        .buttonStyle(.plain)
                        Divider()
                            .frame(height: 1)
                            .overlay(.blackAndWhite)
                            .opacity(0.2)
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
}

#Preview {
    MainFeedView(viewModel: PostViewModel(model: PostModel()))
}
