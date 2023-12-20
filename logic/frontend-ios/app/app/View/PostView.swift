

import SwiftUI

struct PostView: View {
    var postId: Int
    @State var post: PollPostViewModel?
    @State var dict = [Int:String]()
    @State var postStatus:Status = .CLOSED
    @State var answerOption = ""
    @State var answerCreatorIds = [Int]()
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                VStack(alignment: .leading) {
                    Text(post?.creatorName ?? "")
                    Text(post?.createdOn ?? "")
                }
                Spacer()
                if(post?.creatorId == UserDefaults.standard.integer(forKey: "userId")){
                    Picker("Status", selection: $postStatus) {
                        ForEach(Status.allCases, id: \.self) { val in
                            Text(val.rawValue)
                                .tag(val)
                        }
                    }
                    .onChange(of: postStatus) {
                        Task {
                            do {
                                await updateStatus(postId: post?.postId ?? -1, postStatus: postStatus)
                            }
                        }
                    }
                }else {
                    Text("\((post?.status ?? .OPEN).rawValue)")
                }
            }
            .background(Color.green.opacity(0.1))
            
            VStack(alignment: .leading) {
                Text(post?.title ?? "")
                Text(post?.definiton ?? "")
            }
            .background(Color.red.opacity(0.1))
            
            HStack {
                VStack(alignment: .leading) {
                    ForEach(post?.postDetails ?? [Poll_PostDetailModel](), id: \.postDetailsId) { detail in
                        HStack {
                            Text(detail.createdOn ?? "")
                            Text("\(detail.creatorName ?? "") :")
                            Text("\(dict[detail.poll_answerId ?? 0] ?? "")")
                        }
                    }
                    
                }
                .background(Color.yellow.opacity(0.1))
                
                VStack(alignment: .trailing) {
                    if(post?.creatorId != UserDefaults.standard.integer(forKey: "userId") && !answerCreatorIds.contains(UserDefaults.standard.integer(forKey: "userId")) && post?.status == .OPEN){
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
                                do {
                                    let key = dict.first(where: { $0.value == answerOption})?.key
                                    let status = await createPostDetail(creatorId: UserDefaults.standard.integer(forKey: "userId"), postId: post?.postId ?? -1, pollAnswerId: key ?? -1)
                                    
                                    await loadView()
                                    
                                }
                            }
                        }
                    }
                }
            }
        }.task {
            await loadView()
        }
        .frame(width: UIScreen.main.bounds.width - 20)
        .background(Color.black.opacity(0.1))
    }
    
    func loadView() async {
        post = await PollPostViewModel(model: loadPost(postId: postId) as! Poll_PostModel)
        for answer in post?.typeInfo.pollAnswers ?? [Poll_PostAnswerModel]() {
            dict.updateValue(answer.title ?? "", forKey: answer.poll_answerId ?? 0)
        }
        postStatus = post?.status ?? .OPEN
        
        for detail in post?.postDetails ?? [Poll_PostDetailModel]() {
            answerCreatorIds.append(detail.creatorId ?? -1)
        }
    }
}

#Preview {
    PostView(postId: 102)
}

