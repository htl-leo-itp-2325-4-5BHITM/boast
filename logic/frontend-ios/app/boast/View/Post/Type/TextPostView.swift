
import SwiftUI

struct TextPostView: View {
    var post: TextPostViewModel
    @State var postStatus:Status = .OPEN
    @State var answerCreatorIds = [Int]()
    @State var postAnswers = [String:Int]()
    @State var definition = ""
    @State var comment = ""
    @State var alert = false
    @State var winner = ""
    @State var winnerId = -1
    @State var winnerSubmited = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                HStack {
                    Image(systemName: "person.circle")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 50)
                    VStack(alignment: .leading) {
                        NavigationLink(destination: UserProfileView(userId: post.creatorId)) {
                            Text(post.creatorName)
                                .font(.title)
                        }
                        .foregroundStyle(.blackAndWhite)
                        Text("@\(post.creatorName)")
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
                                    alert = postStatus == .CLOSED
                                    _ = await updateStatus(postId: post.postId, postStatus: postStatus)
                                }
                            }
                        }
                        .alert("Winner", isPresented: $alert, actions: {
                            TextField("Winner: ", text: $winner)
                            Button("Submit", action: {
                                if postAnswers[winner] != nil {
                                    winnerSubmited = true
                                    winnerId = postAnswers[winner] ?? -1
                                }
                            })
                        }, message: {
                            Text("Please pick a winner.")
                        })
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
                
                Divider()
                    .frame(height: 1)
                    .overlay(.blackAndWhite)
                
                if (postAnswers[winner] != -1 || postAnswers[winner] != nil) && winnerSubmited && postStatus != .OPEN && winner != "" {
                    Section {
                        VStack(alignment: .leading){
                            Text("Winner: ")
                                .font(.largeTitle)
                        }
                        HStack {
                            Spacer()
                            Image(systemName: "person.circle")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 60)
                            VStack{
                                NavigationLink(destination: UserProfileView(userId: winnerId)) {
                                    Text(winner)
                                        .font(.title)
                                }
                                .foregroundStyle(.blackAndWhite)
                                Text("@\(winner)")
                            }
                            Spacer()
                        }
                    }
                    HStack(alignment: .firstTextBaseline) {
                        Rectangle()
                            .fill(.yellow)
                            .frame(height: 30)
                        Rectangle()
                            .fill(.yellow)
                            .frame(height: 100)
                        Rectangle()
                            .fill(.yellow)
                            .frame(height: 60)
                    }
                    Divider()
                        .frame(height: 1)
                        .overlay(.blackAndWhite)
                }
                
                
                Text("Bets: ")
                    .font(.largeTitle)
                
                VStack(alignment: .leading) {
                    Text(comment)
                    ForEach(post.postDetails, id: \.postDetailsId) { detail in
                        HStack {
                            Image(systemName: "person.circle")
                            Text("\(detail.creatorName ?? "") :")
                            Text("\(detail.text ?? "")")
                        }
                    }
                }
                
                if(!answerCreatorIds.contains(UserDefaults.standard.integer(forKey: "userId")) && post.status == .OPEN){
                    VStack(alignment: .leading) {
                        Text("Place your bet: ")
                            .font(.title)
                        HStack {
                            TextField("Answer", text: $definition, axis: .vertical)
                                .padding(5)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10.0)
                                        .stroke(.blackAndWhite)
                                )
                            
                            Button("Submit", action: {
                                Task {
                                    if definition != "" {
                                        let status = createTextPostDetail(creatorId: UserDefaults.standard.integer(forKey: "userId"), postId: post.postId, text: definition)
                                        answerCreatorIds.append(UserDefaults.standard.integer(forKey: "userId"))
                                        let df = DateFormatter()
                                        df.dateFormat = "dd.MM.yyyy"
                                        comment = "\(UserDefaults.standard.string(forKey: "userName") ?? "") : \(definition)"
                                    }
                                }
                            })
                            .buttonStyle(.borderedProminent)
                            
                        }
                    }
                }
                
                Spacer()
            }.task {
                postStatus = post.status
                for detail in post.postDetails {
                    answerCreatorIds.append(detail.creatorId ?? -1)
                    postAnswers.updateValue(detail.creatorId ?? -1, forKey: detail.creatorName ?? "")
                }
                print(postAnswers)
                print(postAnswers["cunt"])
            }
            .frame(width: UIScreen.main.bounds.width - 20)
        }
    }
}
