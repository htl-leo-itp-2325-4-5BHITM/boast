
import SwiftUI

struct PollAnswers: Identifiable, Hashable {
    let id = UUID()
    var pollId: Int = -1
    var title: String = ""
}

struct PickPollPostWinner: View {
    var post: PollPostViewModel
    @State var response = -1
    @State private var editMode = EditMode.active
    @State var selectedItems: PollAnswers? = PollAnswers()
    @State var pollAnswers = [PollAnswers]()
    @State var returnToView = false
    
    var body: some View {
        NavigationStack {
            VStack {
                List(selection: $selectedItems) {
                    ForEach(pollAnswers, id: \.self) { answer in
                        Text("\(answer.title)")
                            .tag(answer)
                    }
                    Section {
                        Button(action: {
                            if selectedItems?.pollId != -1 {
                                Task {
                                    await setPollPostWinner(postId: post.postId, pollId: selectedItems?.pollId ?? -1)
                                }
                            }
                        }, label: {
                            Text("Submit")
                        })
                        .disabled(returnToView)
                    }
                }
            }
        }
        .environment(\.editMode, $editMode)
        .navigationTitle("Pick a winner")
        .task {
            for answer in post.typeInfo.pollAnswers ?? [Poll_PostAnswerModel]() {
                pollAnswers.append(PollAnswers(pollId: answer.poll_answerId ?? -1, title: answer.title ?? ""))
            }
        }
        
    }
}
