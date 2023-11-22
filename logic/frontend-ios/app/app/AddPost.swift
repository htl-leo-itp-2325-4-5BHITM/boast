
import SwiftUI

struct AddPost: View {
    @ObservedObject var postModel = PostModel()
    @State var counter = 2
    
    var body: some View {
        ScrollView {
            Text("Create new Bet").font(.largeTitle)
            Form {
                TextField("Title", text: $postModel.title)
                TextField("Creator", text: $postModel.creator)
                TextField("Definition", text: $postModel.definition, axis: .vertical)
                    .lineLimit(3, reservesSpace: true)
            }
            .frame(width: 400, height: 300)
            .padding(0)
            .scrollDisabled(true)
            
            ForEach(0..<counter, id: \.self){ i in
                @State var betCreator: String = ""
                @State var bet: String = ""
            
                Form {
                    TextField("Creator \(i+1)", text: $postModel.postDetails[i].creator)
                    TextField("Bet \(i+1)", text: $postModel.postDetails[i].bet)
                }
                .frame(width: 400, height: 150)
            }
            
            Button("Add bet") {
                counter += 1;
                postModel.addPostDetail()
            }
            
            Spacer(minLength: 20)
            
            Button("Submit Bet", action: { Task {
                await addPost(postModel: postModel)
            }})
            .buttonStyle(.borderedProminent)
        }
    }
}

#Preview {
    AddPost()
}
