
import SwiftUI



struct LoginView: View {
    @ObservedObject var viewModel: UserViewModel
    @State var userId: Int = -1
    @State var goNext: Bool = false
    var body: some View {
        NavigationStack{
            VStack {
                Form {
                    Section(header: Text("Login:")) {
                        TextField("Name", text: Binding(
                            get: {
                                viewModel.username
                            },
                            set: {
                                if $0 != viewModel.username {
                                    viewModel.dataChanged(username: $0)
                                }
                            }
                        ))
                        Button("Submit", action: {
                            Task {
                                userId = try await userLogin(userName: viewModel.username)
                                if userId != -1 {
                                    UserDefaults.standard.set(userId, forKey: "userId")
                                    UserDefaults.standard.set(viewModel.username, forKey: "userName")
                                    goNext = true
                                }
                            }
                        })
                    }
                }
                
                NavigationLink(destination: AllViews().navigationBarBackButtonHidden(), isActive: $goNext){}.hidden()
            }
        }
        .task {
            UNUserNotificationCenter.current().requestAuthorization(options: [.badge]) { (success, error) in
                print("Success")
            }
        }
    }
}

#Preview {
    LoginView(viewModel: UserViewModel(model: UserModel()))
}
