
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
                                        do {
                                            if postStatus == .CLOSED && post.model.winners == [] {
                                                alert = true
                                            }
                                            _ = await updateStatus(postId: post.postId, postStatus: postStatus)
                                        }
                                    }
                                }
                            }else {
                                Text((post.status).rawValue)
                            }
                            if postStatus == .CLOSED {
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
                    
                    if (postStatus == .CLOSED && post.model.winners != []) {
                        Section {
                            VStack(alignment: .leading){
                                Text("Winner: ")
                                    .font(.largeTitle)
                            }
                            
                            ForEach(post.model.winners ?? [], id: \.self) { winner in
                                HStack {
                                    Spacer()
                                    VStack{
                                        NavigationLink(destination: UserProfileView(userId: winner)) {
                                            Text("\(creatorAnswers[winner] ?? "")")
                                                .font(.title)
                                        }
                                        .foregroundStyle(.blackAndWhite)
                                    }
                                    .scaleEffect(1.0)
                                    Spacer()
                                }
                                
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
                }
                
                VStack(alignment: .leading) {
                    Text("Bets: ")
                        .font(.largeTitle)
                    HStack {
                        Text(comment)
                        Spacer()
                    }
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
                                    }
                                }
                            })
                            .buttonStyle(.borderedProminent)
                            
                        }
                    }
                }
                
                Spacer()
            }
        }
        .frame(width: UIScreen.main.bounds.width - 20)
        .task {
            postStatus = post.status
            for detail in post.postDetails {
                answerCreatorIds.append(detail.creatorId ?? -1)
                postAnswers.updateValue(detail.creatorId ?? -1, forKey: detail.creatorName ?? "")
                creatorAnswers.updateValue(detail.creatorName ?? "", forKey: detail.creatorId ?? 0)
                print(detail)
            }
            print(post.model.winners ?? [])
            print(creatorAnswers)
        }
    }
}


#Preview {
    AllViews()
}
