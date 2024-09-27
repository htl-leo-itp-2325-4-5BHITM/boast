

import SwiftUI

struct postAnswers: Identifiable, Hashable {
    let id = UUID()
    var creatorID: Int = -1
    var answer: String = ""
}

struct PickTextPostWinner: View {
    var post: TextPostViewModel
    @State var response = -1
    @State private var editMode = EditMode.active
    @State var firstPlace = -1
    @State var secondPlace = -1
    @State var thirdPlace = -1
    
    @State var answers = [postAnswers]()
    @State var returnToView = false
    var body: some View {
        NavigationStack {
            VStack {
                Text("Pick the best 3 answers")
                    .font(.title)
                Spacer()
                HStack(alignment: .bottom) {
                    VStack {
                        Picker("Choose second place!", selection: $secondPlace) {
                            Text("").tag(-1)
                            ForEach(answers, id: \.creatorID) { answer in
                                Text(answer.answer)
                                    .tag(answer.creatorID)
                            }
                        }
                        .buttonStyle(BorderedProminentButtonStyle())
                        ZStack {
                            Rectangle()
                                .fill(.yellow)
                                .frame(height: 60)
                            Text("2nd")
                        }
                    }
                    
                    VStack {
                        Picker("", selection: $firstPlace) {
                            Text("").tag(-1)
                            ForEach(answers, id: \.creatorID) { answer in
                                Text(answer.answer).tag(answer.creatorID)
                            }
                        }
                        .buttonStyle(BorderedProminentButtonStyle())
                        ZStack {
                            Rectangle()
                                .fill(.yellow)
                                .frame(height: 100)
                            VStack {
                                Text("👑")
                                    .font(.largeTitle)
                                Text("1st")
                            }
                        }
                    }
                    
                    
                    VStack {
                        Picker("", selection: $thirdPlace) {
                            Text("").tag(-1)
                            ForEach(answers, id: \.creatorID) { answer in
                                Text(answer.answer).tag(answer.creatorID)
                            }
                        }
                        .buttonStyle(BorderedProminentButtonStyle())
                        ZStack {
                            Rectangle()
                                .fill(.yellow)
                                .frame(height: 30)
                            Text("3rd")
                        }
                    }
                }
                
                Button("Submit", action: {
                    var ranking = WinnerRanking()
                    ranking.first = [firstPlace]
                    ranking.second = [secondPlace]
                    ranking.third = [thirdPlace]
                    
                    if ranking.first == [-1] {
                        ranking.first = []
                    }
                    if ranking.second == [-1] {
                        ranking.second = []
                    }
                    if ranking.third == [-1] {
                        ranking.third = []
                    }
                    Task {
                        await setTextPostWinner(postId: post.postId, winners: ranking)
                    }
                })
                .buttonStyle(.borderedProminent)
                Spacer()
            }
        }
        .navigationTitle("Pick a winner!")
        .task {
            for detail in post.postDetails {
                answers.append(postAnswers(creatorID: detail.creatorId ?? -1, answer: detail.text ?? ""))
                print(answers)
            }
        }
    }
}

#Preview {
    AllViews()
}
