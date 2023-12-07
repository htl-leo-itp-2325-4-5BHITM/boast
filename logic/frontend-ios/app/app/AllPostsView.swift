
import SwiftUI

struct GetPostsAsList: View {
    @State private var posts = [PostModel]()
    var body: some View {
        ScrollView{
            VStack {
                Text("All Bets: ")
                    .frame(width: 330, alignment: .leading)
                    .font(.largeTitle)
                ForEach(posts, id: \.id) { post in
                    VStack(alignment: .leading) {
                        Text("Titel: \(post.title)")
                            .font(.title)
                        Text("Creator: \(post.creator)\n")
                        Text("Definition: \(post.definition) \n")
                        Text("Winner: \(post.winner)")
                        Text("")
                            .frame(width: 300)
                        Text("Bets: ")
                            .font(.headline)
                        ForEach(post.postDetails, id: \.id) { details in
                            Text("\(details.bet)  \(details.creator)")
                        }
                    }
                    .frame(width: 300)
                    .padding()
                    .background(Color(.black).opacity(0.1))
                }
            }
            .task {
                posts = await getPostsAsList()
            }
            .padding()
        }
    }
}

#Preview {
    GetPostsAsList()
}