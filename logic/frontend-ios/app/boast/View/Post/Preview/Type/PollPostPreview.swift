

import SwiftUI

struct PollPostPreview: View {
    var post: Poll_PostModel?
    @State var postStatus:Status = .OPEN
    @State var answerOption = ""
    @State var dict = [Int:String]()
    @State var answerCreatorIds = [Int]()

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                VStack(alignment: .leading) {
                    Text(post?.creatorName ?? "")
                        .font(.title3)
                    Text(post?.createdOn ?? "")
                }
                Spacer()
            }
            
            VStack(alignment: .leading) {
                Text(post?.title ?? "")
                    .bold()
                    .font(.title)
                Text(post?.definition ?? "")
                    .font(.title)
            }
        }
        .frame(width: UIScreen.main.bounds.width - 20)
    
    }
}
