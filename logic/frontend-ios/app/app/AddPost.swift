
import SwiftUI

struct AddPost: View {
    @State private var numberOfRects = 0
    @State private var title: String = ""
    @State private var creator: String = ""
    @State private var description: String = ""
    @State private var counter: Int = 2
    @State var details = [PostDetail]()
    
    var body: some View {
        ScrollView {
            Text("Create new Bet").font(.largeTitle)
            Form {
                TextField("Title", text: $title)
                TextField("Creator", text: $creator)
                TextField("Description", text: $description, axis: .vertical)
                    .lineLimit(3, reservesSpace: true)
                Stepper("Number of Participants: \(counter)", value: $counter, in: 2...99)
            }
            .frame(width: 400, height: 300)
            .padding(0)
            .scrollDisabled(true)
            
            ForEach(0..<counter, id: \.self){ i in
                @State var betCreator: String = ""
                @State var bet: String = ""
                Form {
                    TextField("Creator \(i+1)", text: $betCreator)
                    TextField("Bet \(i+1)", text: $bet)
                }
                .frame(width: 400, height: 150)
            }
            
            Spacer(minLength: 20)
            
            Button("Submit Bet", action: {
                
            })
            .buttonStyle(.borderedProminent)
        }
    }
}

#Preview {
    AddPost()
}
