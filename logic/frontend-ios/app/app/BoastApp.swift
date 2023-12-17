

import SwiftUI

fileprivate let model = Poll_PostModel()

@main
struct BoastApp: App {
    var body: some Scene {
        var viewModel = PollPostViewModel(model: Poll_PostModel())
        WindowGroup {
            TabView{
                PostsView(viewModel: viewModel)
            }
        }
    }
}
