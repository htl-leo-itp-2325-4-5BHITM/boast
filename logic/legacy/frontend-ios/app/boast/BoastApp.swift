

import SwiftUI

fileprivate let userModel = UserModel()

@main
struct BoastApp: App {
    var body: some Scene {
        var userViewModel = UserViewModel(model: userModel)
        WindowGroup {
            if UserDefaults.standard.string(forKey: "userId") != nil {
                AllViews()
            }else {
                LoginView(viewModel: userViewModel)
            }
            
        }
    }
}
