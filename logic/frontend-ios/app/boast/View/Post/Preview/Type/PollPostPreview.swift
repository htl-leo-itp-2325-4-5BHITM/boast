

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
                    Text(post?.title ?? "")
                        .font(.system(size: 30, weight: .semibold))
                }
                Spacer()
                Text("") // TODO
                    .font(.title)
                    .bold()
                    .padding()
                    //.background(.gray)
                    .clipShape(.buttonBorder)
                    //.border(.blackAndWhite)
            }
            VStack(alignment: .leading) {
                Text(post?.definition ?? "")
                    .font(.system(size: 20))
            }
            
            VStack {
                ForEach(post?.typeInfo?.pollAnswers ?? [Poll_PostAnswerModel](), id: \.poll_answerId) { answer in
                    HStack {
                        Text("\(answer.title ?? "")")
                        Spacer()
                    }
                    .padding(10)
                    .frame(width: UIScreen.main.bounds.width - 20)
                    .overlay(
                        RoundedRectangle(cornerRadius: 30)
                            .stroke(.blackAndWhite, lineWidth: 3)
                            .padding(1)
                    )
                }
                
                HStack {
                    Text("@\(post?.creatorName ?? "")")
                    Text("|")
                    Text("\(post?.postDetails?.count ?? 0) vote")
                    Spacer()
                }
                .font(.system(size: 14))
                .foregroundColor(.gray)
            }
        }
        .frame(width: UIScreen.main.bounds.width - 20)
        
    }
}
