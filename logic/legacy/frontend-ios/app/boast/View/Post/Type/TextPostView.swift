
import SwiftUI

struct TextPostView: View {
    var post: TextPostViewModel
    @State var postStatus:Status = .OPEN
    @State var answerCreatorIds = [Int]()
    @State var postAnswers = [String:Int]()
    @State var creatorAnswers = [Int:String]()
    @State var definition = ""
    @State var comment = ""
    @State var alert = false
    @State var winnerSubmited = false
    @State var hideComment = true
    
    
    var body: some View {
        NavigationStack {
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
                        VStack {
                            if(post.creatorId == UserDefaults.standard.integer(forKey: "userId")){
                                Picker("Status", selection: $postStatus) {
                                    ForEach(Status.allCases, id: \.self) { val in
                                        Text(val.rawValue)
                                            .tag(val)
                                    }
                                }
                                .buttonStyle(BorderedButtonStyle())
                                .onChange(of: postStatus) {
                                    
                                    Task {
                                        await updateStatus(postId: post.postId, postStatus: postStatus)
                                    }
                                    
                                }
                            }else {
                                Text((post.status).rawValue)
                            }
                            if postStatus == .CLOSED && (post.winnerRanking.first == [] || post.winnerRanking.second == [] || post.winnerRanking.third == []) {
                                NavigationLink(destination: PickTextPostWinner(post: post)) {
                                    Text("Pick a winner!")
                                        .padding(5)
                                        .background(.blue)
                                        .foregroundStyle(.white)
                                        .buttonStyle(BorderedButtonStyle())
                                }
                            }
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
                    
                }
                
                VStack(alignment: .leading) {
                    Text("Bets: ")
                        .font(.largeTitle)
                    HStack {
                        Image(systemName: "person.circle")
                        Text(comment)
                        Spacer()
                    }
                    .opacity(hideComment ? 0 : 1)
                    
                    
                    
                    ForEach(post.postDetails, id: \.postDetailsId) { detail in
                        HStack {
                            Image(systemName: "person.circle")
                            Text("\(detail.creatorName ?? "") :")
                            Text("\(detail.text ?? "")")
                            Spacer()
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
                                        hideComment = false
                                    }
                                }
                            })
                            .buttonStyle(.borderedProminent)
                        }
                    }
                }
                
                Spacer(minLength: 20)
                if post.winnerRanking.first != [] {
                    VStack(alignment: .leading) {
                        Text("Winners: ")
                            .font(.largeTitle)
                        HStack(alignment: .bottom) {
                            VStack {
                                NavigationLink(destination: UserProfileView(userId: post.winnerRanking.second?.first ?? -1)) {
                                    Text("\(creatorAnswers[post.winnerRanking.second?.first ?? 0] ?? "")")
                                        .font(.title)
                                }
                                ZStack {
                                    Rectangle()
                                        .fill(.yellow)
                                        .frame(height: 55)
                                    Rectangle()
                                        .fill(.whiteAndBlack)
                                        .frame(height: 45)
                                        .padding(.top)
                                }
                                
                            }
                            VStack {
                                NavigationLink(destination: UserProfileView(userId: post.winnerRanking.first?.first ?? -1)) {
                                    Text("👑 \(creatorAnswers[post.winnerRanking.first?.first ?? 0] ?? "")")
                                        .font(.title)
                                }
                                ZStack {
                                    Rectangle()
                                        .fill(.yellow)
                                        .frame(height: 80)
                                    Rectangle()
                                        .fill(.whiteAndBlack)
                                        .frame(height: 70)
                                        .padding(.top)
                                }
                            }
                            VStack {
                                NavigationLink(destination: UserProfileView(userId: post.winnerRanking.third?.first ?? -1)) {
                                    Text("\(creatorAnswers[post.winnerRanking.third?.first ?? 0] ?? "")")
                                        .font(.title)
                                }
                                ZStack {
                                    Rectangle()
                                        .fill(.yellow)
                                        .frame(height: 30)
                                    Rectangle()
                                        .fill(.whiteAndBlack)
                                        .frame(height: 20)
                                        .padding(.top)
                                }
                            }
                        }
                    }
                }
            }
        }
        .frame(width: UIScreen.main.bounds.width - 20)
        .task {
            postStatus = post.status
            for detail in post.postDetails {
                answerCreatorIds.append(detail.creatorId ?? -1)
                postAnswers.updateValue(detail.creatorId ?? -1, forKey: detail.creatorName ?? "")
                creatorAnswers.updateValue(detail.creatorName ?? "", forKey: detail.creatorId ?? 0)
            }
        }
    }
}


#Preview {
    AllViews()
}
