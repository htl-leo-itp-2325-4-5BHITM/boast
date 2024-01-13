

import SwiftUI

fileprivate let postModel = PostModel()

struct AllViews: View {
    let postViewModel = PostViewModel(model: postModel)
    var body: some View {
        TabView{
            MainFeedView(viewModel: postViewModel)
                .tabItem {
                    Image(systemName: "house")
                }
            CreatePostView()
                .tabItem {
                    Image(systemName: "plus")
                }
        }
    }
}

#Preview {
    AllViews()
}
