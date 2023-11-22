
import SwiftUI

struct AddPost: View {
    @ObservedObject var postModel = PostModel()
    @State var counter = 2
    @State var error = ""
    
    var body: some View {
        ScrollView {
            Text("Create new Bet").font(.largeTitle)
            Form {
                TextField("Title", text: $postModel.title)
                TextField("Creator", text: $postModel.creator)
                TextField("Definition", text: $postModel.definition, axis: .vertical)
                    .lineLimit(3, reservesSpace: true)
                TextField("Winner", text: $postModel.winner)
            }
            .frame(width: 400, height: 300)
            .padding(0)
            .scrollDisabled(true)
            Text(error)
                .foregroundStyle(Color(.red))
            
            ForEach(0..<counter, id: \.self){ i in
                @State var betCreator: String = ""
                @State var bet: String = ""
            
                Form {
                    TextField("Creator \(i+1)", text: $postModel.postDetails[i].creator)
                    TextField("Bet \(i+1)", text: $postModel.postDetails[i].bet)
                }
                .frame(width: 400, height: 150)
            }
            
            Spacer(minLength: 20)

            Button("Add bet") {
                counter += 1;
                postModel.addPostDetail()
            }
            
            Spacer(minLength: 20)
            
            Button("Submit Bet", action: { Task {
                
                if(postModel.title != "" && postModel.creator != "" && postModel.definition != "" && postModel.winner != "") {
                    await addPost(postModel: postModel)
                }else {
                    error = "Fields must not be empty"
                }
            }})
            .buttonStyle(.borderedProminent)
        }
    }
}

#Preview {
    AddPost()
}
