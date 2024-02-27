

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
            Create()
                .tabItem {
                    Image(systemName: "plus.app")
                }
            SearchView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                }
            ProfileView()
                .tabItem {
                    Image(systemName: "person.circle")
                }
        }
    }
}

#Preview {
    AllViews()
}
