

import SwiftUI

@main
struct BoastApp: App {
    var body: some Scene {
        WindowGroup {
            TabView{
                CreatePostView()
            }
        }
    }
}
