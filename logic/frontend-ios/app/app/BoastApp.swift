

import SwiftUI

@main
struct BoastApp: App {
    var body: some Scene {
        WindowGroup {
            TabView{
                GetPostsAsList()
                    .tabItem {
                        Label("All bets",
                              systemImage: "list.bullet.circle")
                    }
                AddPost()
                    .tabItem {
                        Label("Create new bet", systemImage: "plus.circle")
                    }
            }
        }
    }
}
