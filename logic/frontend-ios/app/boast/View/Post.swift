

import SwiftUI

struct Post: View {
    var postId: Int
    
    @State var post: PollPostViewModel?
    @State var dict = [Int:String]()
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                VStack(alignment: .leading) {
                    Text(post?.creatorName ?? "")
                    Text(post?.createdOn ?? "")
                }
                Spacer()
                Text("\((post?.status ?? .OPEN).rawValue)")
            }
            //.background(Color.green.opacity(0.1))
            
            VStack(alignment: .leading) {
                Text(post?.title ?? "")
                Text(post?.definiton ?? "")
            }
            //.background(Color.red.opacity(0.1))

            VStack(alignment: .leading) {
                ForEach(post?.postDetails ?? [Poll_PostDetailModel](), id: \.postDetailsId) { detail in
                    HStack {
                        Text(detail.createdOn ?? "")
                        Text("\(detail.creatorName ?? "") :")
                        Text("\(dict[detail.poll_answerId ?? 0] ?? "")")
                    }
                }
            }
            //.background(Color.yellow.opacity(0.1))
        }.task {
            do {
                post = try await PollPostViewModel(model: loadPost(postId: postId) as! Poll_PostModel)
                for answer in post?.typeInfo.pollAnswers ?? [Poll_PostAnswerModel]() {
                    dict.updateValue(answer.title ?? "", forKey: answer.poll_answerId ?? 0)
                }
            }catch {
                print("too fast")
            }
        }
        .frame(width: UIScreen.main.bounds.width - 20)
        //.background(Color.black.opacity(0.1))

    }
}

#Preview {
    Post(postId: 100)
}

