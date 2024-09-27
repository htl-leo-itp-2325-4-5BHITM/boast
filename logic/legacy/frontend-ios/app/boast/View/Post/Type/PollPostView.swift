

import SwiftUI

struct PollPostView: View {
    @ObservedObject var post: PollPostViewModel
    @State var postStatus:Status = .OPEN
    @State var answerOption = ""
    @State var dict = [Int:String]()
    @State var answerCreatorIds = [Int]()
    @State var betEntry = ""
    var barLength = UIScreen.main.bounds.width - 20
    @State var bets = [Int:Int]()
    @State var validVotes = 0
    @State var voteLength = 0.0
    @State var alert = false
    @State var winner = ""
    @State var playerHasNotVoted = true
    
    var body: some View {
        
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
                    if postStatus == .CLOSED && post.winnerPoll == -1 {
                        NavigationLink(destination: PickPollPostWinner(post: post)) {
                            Text("Pick a winner!")
                                .padding(5)
                                .background(.blue)
                                .foregroundStyle(.white)
                                .buttonStyle(BorderedButtonStyle())
                        }
                    }
                }
            }
            Divider()
                .frame(height: 1)
                .overlay(.blackAndWhite)
            
            VStack(alignment: .leading) {
                Text(post.title)
                    .font(.largeTitle)
                    .bold()
                Text(post.definiton)
                    .font(.title2)
            }
            
            Section {
                VStack {
                    ForEach(post.typeInfo.pollAnswers ?? [Poll_PostAnswerModel](), id: \.poll_answerId) { answer in
                        if playerHasNotVoted {
                            Button(action: {
                                createPostDetail(creatorId: UserDefaults.standard.integer(forKey: "userId"), postId: post.postId, pollAnswerId: answer.poll_answerId ?? -1)
                                playerHasNotVoted = false
                            }, label: {
                                ZStack {
                                    HStack {
                                        Text("\(answer.title ?? "")")
                                            .foregroundStyle(.blackAndWhite)
                                        Spacer()
                                    }
                                    .padding(10)
                                    .frame(width: barLength)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 30)
                                            .stroke(Color.teal, lineWidth: 3)
                                            .padding(1)
                                    )
                                }
                            })
                        } else {
                            ZStack {
                                HStack {
                                    Text("")
                                        .padding(12)
                                        .frame(width: (Double(bets[answer.poll_answerId ?? 0] ?? 0) * voteLength), alignment: .leading)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 30)
                                                .fill(Color(answer.poll_answerId ?? -1 == post.winnerPoll ? .green : .teal))
                                                .padding(1)
                                        )
                                }
                                .frame(width: barLength, alignment: .leading)
                                
                                HStack {
                                    Text("\(answer.title ?? "")")
                                        .foregroundStyle(.blackAndWhite)
                                    Spacer()
                                }
                                .padding(10)
                                .frame(width: barLength)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 30)
                                        .stroke(Color(answer.poll_answerId ?? -1 == post.winnerPoll ? .green : .teal), lineWidth: 3)
                                        .padding(1)
                                )
                            }
                        }
                    }
                }
            }
            Spacer()
            
        }.task {
            for answer in post.typeInfo.pollAnswers ?? [Poll_PostAnswerModel]() {
                dict.updateValue(answer.title ?? "", forKey: answer.poll_answerId ?? 0)
            }
            for detail in post.postDetails {
                if UserDefaults.standard.integer(forKey: "userId") == detail.creatorId {
                    playerHasNotVoted = false
                }
                bets.updateValue(detail.postDetailsId ?? -1, forKey: detail.poll_answerId ?? -1)
                answerCreatorIds.append(detail.creatorId ?? -1)
            }
            print(post.winnerPoll ?? 0)
            calcVisualShit()
        }
        .frame(width: UIScreen.main.bounds.width - 20)
    }
    func calcVisualShit(){
        for val in bets {
            validVotes += val.value
        }
        voteLength = barLength/Double(validVotes)
        postStatus = post.status
    }
}

#Preview {
    AllViews()
}
