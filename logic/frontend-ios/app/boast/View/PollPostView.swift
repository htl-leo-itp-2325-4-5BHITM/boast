

import SwiftUI

struct PollPostView: View {
    var post: PollPostViewModel
    @State var postStatus:Status = .OPEN
    @State var answerOption = ""
    @State var dict = [Int:String]()
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
                                print(post.postId, postStatus)
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

        }.task {
            for answer in post.typeInfo.pollAnswers ?? [Poll_PostAnswerModel]() {
                dict.updateValue(answer.title ?? "", forKey: answer.poll_answerId ?? 0)
            }
            postStatus = post.status
        }
        .frame(width: UIScreen.main.bounds.width - 20)
        //.background(Color.black.opacity(0.1))
        
    }
}
