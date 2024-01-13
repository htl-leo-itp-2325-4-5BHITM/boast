

import SwiftUI

fileprivate let userModel = UserModel()

@main
struct BoastApp: App {
    var body: some Scene {
        var userViewModel = UserViewModel(model: userModel)
        WindowGroup {
            VStack{
                LoginView(viewModel: userViewModel)
            }
        }
    }
}
