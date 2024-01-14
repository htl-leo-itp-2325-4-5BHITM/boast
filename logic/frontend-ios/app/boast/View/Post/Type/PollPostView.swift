

import SwiftUI

struct PollPostView: View {
    var post: PollPostViewModel
    @State var postStatus:Status = .OPEN
    @State var answerOption = ""
    @State var dict = [Int:String]()
    @State var answerCreatorIds = [Int]()

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                VStack(alignment: .leading) {
                    Text(post.creatorName)
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
            //.background(Color.green.opacity(0.1))
            
            VStack(alignment: .leading) {
                Text(post.title)
                Text(post.definiton)
            }
            //.background(Color.red.opacity(0.1))
            
            VStack(alignment: .leading) {
                ForEach(post.postDetails, id: \.postDetailsId) { detail in
                    HStack {
                        Text(detail.createdOn ?? "")
                        Text("\(detail.creatorName ?? "") :")
                        Text("\(dict[detail.poll_answerId ?? 0] ?? "")")
                    }
                }
            }
            //.background(Color.yellow.opacity(0.1))

            
            VStack(alignment: .trailing) {
                if(post.creatorId != UserDefaults.standard.integer(forKey: "userId") && !answerCreatorIds.contains(UserDefaults.standard.integer(forKey: "userId")) && post.status == .OPEN){
                    Picker("answers", selection: $answerOption) {
                        Text("No Answer")
                            .tag(-1)
                        ForEach(Array(dict.values), id: \.self) { val in
                            Text("\(val)")
                                .tag(val)
                        }
                    }
                    .onChange(of: answerOption) {
                        Task {
                            print(answerOption)
                            do {
                                let key = dict.first(where: { $0.value == answerOption})?.key
                                let status = await createPostDetail(creatorId: UserDefaults.standard.integer(forKey: "userId"), postId: post.postId , pollAnswerId: key ?? -1)
                            }
                        }
                    }
                }
            }
            
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
        //.background(Color.black.opacity(0.1))
        
    }
}
