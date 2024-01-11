
import SwiftUI

struct LoginView: View {
    @ObservedObject var viewModel = UserViewModel(model: UserModel())
    @State var userId: Int = -1
    @State var goNext: Bool = false
    var body: some View {
        NavigationView{
            VStack {
                Form {
                    Section(header: Text("Name:")) {
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
                    }
                    /*
                    Section(header: Text("Email:")) {
                        TextField("Email", text: Binding(
                            get: {
                                viewModel.email
                            },
                            set: {
                                if $0 != viewModel.email {
                                    viewModel.dataChanged(username: $0)
                                }
                            }
                        ))
                    }*/
                }
                Button("Submit", action: {
                    Task {
                        userId = try await userLogin(userName: viewModel.username)
                        if userId != -1 {
                            UserDefaults.standard.set(userId, forKey: "userId")
                            goNext = true
                        }
                    }
                })
                
                NavigationLink(destination: AllViews().navigationBarBackButtonHidden(), isActive: $goNext){}.hidden()
            }
        }
    }
}

#Preview {
    LoginView()
}
