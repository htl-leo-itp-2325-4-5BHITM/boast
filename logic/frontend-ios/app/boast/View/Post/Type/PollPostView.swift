

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
            
            Section {
                HStack {
                    VStack(alignment: .leading) {
                        NavigationLink(destination: UserProfileView(userId: post.creatorId)) {
                            Text(post.creatorName)
                                .font(.title)
                        }
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
                                    await updateStatus(postId: post.postId, postStatus: postStatus)
                                }
                            }
                        }
                        .alert("Winner", isPresented: $alert, actions: {
                            TextField("Winning Option: ", text: $winner)
                                .keyboardType(.numberPad)
                            Button("Submit", action: {
                                // implement route
                            })
                        }, message: {
                            Text("Please pick a winning option")
                        })
                    }else {
                        Text((post.status).rawValue)
                    }
                }
                Text("\(post.title)")
                Text("\(post.definiton)")
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
                                                .fill(Color.teal)
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
                                        .stroke(Color.teal, lineWidth: 3)
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
