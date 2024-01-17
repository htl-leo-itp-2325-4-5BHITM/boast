

import SwiftUI

struct PollPostView: View {
    @ObservedObject var post: PollPostViewModel
    @State var postStatus:Status = .OPEN
    @State var answerOption = ""
    @State var dict = [Int:String]()
    @State var answerCreatorIds = [Int]()
    @State var betEntry = ""

    var body: some View {
        VStack(alignment: .leading) {
            Spacer()
            HStack {
                VStack(alignment: .leading) {
                    Text(post.creatorName)
                        .font(.title)
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
                                postStatus = await updateStatus(postId: post.postId, postStatus: postStatus)
                                post.dataChanged(status: postStatus)
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
                ForEach(post.postDetails, id: \.creatorId) { detail in
                    HStack {
                        Text(detail.createdOn ?? "")
                        Text("\(detail.creatorName ?? "") :")
                        Text("\(dict[detail.poll_answerId ?? 0] ?? "")")
                    }
                }
                HStack {
                    Text(betEntry)
                }
            }
            
            VStack {
                if(post.creatorId != UserDefaults.standard.integer(forKey: "userId") && !answerCreatorIds.contains(UserDefaults.standard.integer(forKey: "userId")) && post.status == .OPEN){
                    Picker("answers", selection: $answerOption) {
                        Text("No Answer")
                            .tag(-1)
                        ForEach(Array(dict.values), id: \.self) { val in
                            Text("\(val)")
                                .tag(val)
                        }
                    }
                    .buttonStyle(.borderedProminent)
                    .onChange(of: answerOption) {
                        Task {
                            do {
                                let key = dict.first(where: { $0.value == answerOption})?.key
                                let status = await createPostDetail(creatorId: UserDefaults.standard.integer(forKey: "userId"), postId: post.postId , pollAnswerId: key ?? -1)
                                let df = DateFormatter()
                                df.dateFormat = "dd.MM.yyyy"
                                betEntry = "\(df.string(from: Date.now))  \(UserDefaults.standard.string(forKey: "userName") ?? "") : \(answerOption)"
                                                                
                                answerCreatorIds.append(UserDefaults.standard.integer(forKey: "userId"))
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
                answerCreatorIds.append(detail.creatorId ?? -1)
            }
            postStatus = post.status
        }
        .frame(width: UIScreen.main.bounds.width - 20)
    
    }
}

