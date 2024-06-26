
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
                    Image(systemName: "person.circle")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 50)
                    VStack(alignment: .leading) {
                        Text(UserDefaults.standard.string(forKey: "userName") ?? userData?.username ?? "")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        Text("@\(UserDefaults.standard.string(forKey: "userName") ?? userData?.username ?? "")")
                            .font(.callout)
                            .fontWeight(.bold)
                    }
                    Spacer()
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
                .padding()
                
                HStack {
                    NavigationLink(destination: UserListView(userId: UserDefaults.standard.integer(forKey: "userId"), relationType: "following")) {
                        Text("following: \(userData?.following ?? 0)")
                    }
                    NavigationLink(destination: UserListView(userId: UserDefaults.standard.integer(forKey: "userId"), relationType: "followers")) {
                        Text("followers: \(userData?.follower ?? 0)")
                    }
                    Text("Posts: \(userData?.posts?.count ?? 0)")
                }
                
                Divider()
                    .frame(height: 0.5)
                    .overlay(.blackAndWhite)
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
            .task {
                userData = await userInfo(userId: UserDefaults().integer(forKey: "userId"))
            }
        }
        
    }
}

#Preview {
    ProfileView()
}
