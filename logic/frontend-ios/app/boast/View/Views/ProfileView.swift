
import SwiftUI

struct ProfileView: View {
    @State var userData: ProfileModel? = nil
    @State var logout = false
    var body: some View {
        NavigationStack {
            VStack {
                NavigationLink("", destination: LoginView(viewModel: UserViewModel(model: UserModel())).navigationBarBackButtonHidden().toolbar(.hidden, for: .tabBar)
                               , isActive: $logout)
                .hidden()
                HStack {
                    NavigationLink(destination: UserListView(userId: UserDefaults.standard.integer(forKey: "userId"), relationType: "friends")) {
                        Text("Friends: \(userData?.friends ?? 0)")
                    }
                    NavigationLink(destination: UserListView(userId: UserDefaults.standard.integer(forKey: "userId"), relationType: "follows")) {
                        Text("Follows: \(userData?.follows ?? 0)")
                    }
                    Text("Posts: \(userData?.posts?.count ?? 0)")
                }
                
                Spacer()
                
                ScrollView {
                    ForEach(userData?.posts ?? [0], id:\.self) { postId in
                        NavigationLink(destination: Post(postId: postId)) {
                            PostPreview(postId: postId)
                        }
                        .buttonStyle(.plain)
                        Spacer(minLength: 30)
                    }
                }
            }
            .navigationTitle(userData?.username ?? "")
            .toolbarTitleDisplayMode(.inlineLarge)
            .toolbar {
                Button {
                    Task{
                        UserDefaults.standard.removeObject(forKey: "userId")
                        UserDefaults.standard.removeObject(forKey: "userName")
                        logout = true
                    }
                } label: {
                    Image(systemName:  "rectangle.portrait.and.arrow.right")
                }
            }
        }
        .task {
            userData = await userInfo(userId: UserDefaults().integer(forKey: "userId"))
        }
    }
}

#Preview {
    ProfileView()
}
