

import SwiftUI

fileprivate let postModel = PostModel()

struct AllViews: View {
    let postViewModel = PostViewModel(model: postModel)
    @State var notifications: Array<Int>?
    var body: some View {
        TabView{
            MainFeedView(viewModel: postViewModel)
                .tabItem {
                    Image(systemName: "house")
                }
            NotificationView(notifications: notifications ?? [])
                .tabItem {
                    Image(systemName: "bell.fill")
                }
                .badge(notifications?.count ?? 0)
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
        .task {
            await notifications = getNotification()
        }
    }
}

#Preview {
    AllViews()
}
