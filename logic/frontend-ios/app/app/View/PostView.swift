

import SwiftUI

struct PostView: View {
    var postId: Int
    @State var post: PollPostViewModel?
    @State var dict = [Int:String]()
    @State var postStatus:Status = .CLOSED
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
        }.task {
            post = await PollPostViewModel(model: loadPost(postId: postId) as! Poll_PostModel)
            for answer in post?.typeInfo.pollAnswers ?? [Poll_PostAnswerModel]() {
                dict.updateValue(answer.title ?? "", forKey: answer.poll_answerId ?? 0)
            }
            postStatus = post?.status ?? .OPEN
        }
        .frame(width: UIScreen.main.bounds.width - 20)
        .background(Color.black.opacity(0.1))
    }
}

#Preview {
    PostView(postId: 100)
}

