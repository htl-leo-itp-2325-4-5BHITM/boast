

import SwiftUI

fileprivate let postModel = PostModel()

struct AllViews: View {
    let postViewModel = PostViewModel(model: postModel)
    @State var notifications: Array<Int>?
    @State var notification = [NotificationModel]()
    @State var ncount = 0
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
                .badge(ncount)
                .onTapGesture(perform: {
                    ncount = 0
                })
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
            for id in notifications ?? [0] {
                let temp = await getNotificationFromId(id: id)
                if !(temp.read ?? true) {
                    notification.append(temp)
                }
            }
            ncount = notification.count
            Task {
                try await UNUserNotificationCenter.current().setBadgeCount(notification.count)
            }

        }
    }
}

#Preview {
    AllViews()
}
