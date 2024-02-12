
import SwiftUI

struct TextPostView: View {
    var post: TextPostViewModel
    @State var postStatus:Status = .OPEN
    @State var answerCreatorIds = [Int]()
    @State var definition = ""
    @State var comment = ""
    var body: some View {
        VStack(alignment: .leading) {
            Spacer(minLength: 50)
            HStack {
                VStack(alignment: .leading) {
                    NavigationLink(destination: UserProfileView(userId: post.creatorId)) {
                        Text(post.creatorName)
                            .font(.title)
                    }
                    Text(post.createdOn)
                }
                Spacer()
                if(post.creatorId == UserDefaults.standard.integer(forKey: "userId")){
                    Picker("Status", selection: $postStatus) {
                        ForEach(Status.allCases, id: \.self) { val in
                            Text(val.rawValue)
                                .tag(val)
                        }
                    }
                    .onChange(of: postStatus) {
                        Task {
                            do {
                                await updateStatus(postId: post.postId, postStatus: postStatus)
                            }
                        }
                    }
                }else {
                    Text((post.status).rawValue)
                }
            }
            
            VStack(alignment: .leading) {
                Text(post.title)
                    .font(.largeTitle)
                    .bold()
                Text(post.definiton)
                    .font(.title2)
            }
            .padding(.top)
            .padding(.bottom)
            
            VStack(alignment: .leading) {
                ForEach(post.postDetails, id: \.postDetailsId) { detail in
                    HStack {
                        Text(detail.createdOn ?? "")
                        Text("\(detail.creatorName ?? "") :")
                        Text("\(detail.text ?? "")")
                    }
                }
                Text(comment)
            }

            VStack(alignment: .leading) {
                if(post.creatorId != UserDefaults.standard.integer(forKey: "userId") && !answerCreatorIds.contains(UserDefaults.standard.integer(forKey: "userId")) && post.status == .OPEN){
                    Form {
                        VStack {
                            TextField("Answer", text: $definition, axis: .vertical)
                                .lineLimit(3, reservesSpace: true)
                                .textFieldStyle(.roundedBorder)

                            Button("Submit", action: {
                                Task {
                                    if definition != "" {
                                        let status = createTextPostDetail(creatorId: UserDefaults.standard.integer(forKey: "userId"), postId: post.postId, text: definition)
                                        answerCreatorIds.append(UserDefaults.standard.integer(forKey: "userId"))
                                        let df = DateFormatter()
                                        df.dateFormat = "dd.MM.yyyy"
                                        comment = "\(df.string(from: Date.now))  \(UserDefaults.standard.string(forKey: "userName") ?? "") : \(definition)"
                                    }
                                }
                            })
                            .padding()
                            .buttonStyle(.borderedProminent)
                        }
                    }
                    .scrollContentBackground(.hidden)
                }
            }

            Spacer()
        }.task {
            postStatus = post.status
            
            for detail in post.postDetails {
                answerCreatorIds.append(detail.creatorId ?? -1)
            }
        }
        .frame(width: UIScreen.main.bounds.width - 20)
    }
}
