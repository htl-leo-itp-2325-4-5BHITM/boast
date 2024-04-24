

import SwiftUI

struct postAnswers: Identifiable, Hashable {
    let id = UUID()
    var creatorID: Int = -1
    var creatorName: String = ""
}

struct PickTextPostWinner: View {
    var post: TextPostViewModel
    @State var response = -1
    @State private var editMode = EditMode.active
    @State var selectedItems = Set<postAnswers>()
    @State var answers = [postAnswers]()
    @State var returnToView = false
    var body: some View {
        NavigationStack {
            VStack {
                List(selection: $selectedItems) {
                    Section {
                        ForEach(answers, id: \.self) { answer in
                            Text("\(answer.creatorName)")
                                .tag(answer.id)
                        }
                    }
                    Section {
                        Button(action: {
                            Task {
                                var winners = [Int]()
                                for winner in selectedItems {
                                    winners.append(winner.creatorID)
                                }
                                response = await setWinner(postId: post.postId, winners: winners)
                                if response == 200 {
                                    returnToView = true
                                }
                            }
                        }, label: {
                            Text("Submit")
                        })
                        .disabled(returnToView)
                    }
                }
                .environment(\.editMode, $editMode)
                .navigationTitle("Pick a winner")
                
            }
        }
        .task {
            for detail in post.postDetails {
                answers.append(postAnswers(creatorID: detail.creatorId ?? -1, creatorName: detail.creatorName ?? ""))
            }
        }
    }
}

#Preview {
    AllViews()
}
