
import SwiftUI

struct MainFeedView: View {
    @State var postFeed = [Int]()
    @ObservedObject var viewModel: PostViewModel
    @State var feedBool: Bool = true
    var body: some View {
        NavigationStack{
            VStack {
                Spacer(minLength: 20)
                /*
                HStack {
                    /*
                    Button(action: {
                        Task {
                            postFeed = await postsFriends(userId: UserDefaults.standard.integer(forKey: "userId"))
                            feedBool = false
                        }
                    }, label: {
                        Text("Friends")
                            .underline(!feedBool)
                    })
                    Text("|")
                    Button(action: {
                        Task {
                            postFeed = await posts()
                            feedBool = true
                        }
                    }, label: {
                        Text("For You")
                            .underline(feedBool)
                    })
                     */
                    Picker("test", selection: $feedBool) {
                        Text("friends")
                        Text("for you")
                    }
                    Spacer()
                }
                Spacer(minLength: 40)
                 */
                ScrollView {
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
}

#Preview {
    MainFeedView(viewModel: PostViewModel(model: PostModel()))
}
