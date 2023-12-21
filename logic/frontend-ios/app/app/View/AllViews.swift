

import SwiftUI

struct AllViews: View {
    var body: some View {
        TabView{
            MainFeedView()
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
