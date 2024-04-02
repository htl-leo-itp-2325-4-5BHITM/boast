

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
            HStack {
                VStack(alignment: .leading) {
                    Text(post.title)
                        .font(.system(size: 30, weight: .semibold))
                    Text("@\(post.creatorName)")
                        .font(.system(size: 20))
                    
                        .foregroundColor(.blackAndWhite)
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
                Text(post.definiton)
                    .font(.system(size: 20))
            }
            
            
            VStack {
                ForEach(post.typeInfo.pollAnswers ?? [Poll_PostAnswerModel](), id: \.poll_answerId) { answer in
                    HStack {
                        Text("\(answer.title ?? "")")
                            .foregroundStyle(Color.teal)
                        Spacer()
                    }
                    .padding(10)
                    .frame(width: UIScreen.main.bounds.width - 20)
                    .overlay(
                        RoundedRectangle(cornerRadius: 30)
                            .stroke(Color.teal, lineWidth: 3)
                            .padding(1)
                    )
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

