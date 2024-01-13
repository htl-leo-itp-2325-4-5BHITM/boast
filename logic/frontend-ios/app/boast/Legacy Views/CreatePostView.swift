
import SwiftUI

struct CreatePostView: View {
    
    @State var createdOn: String = ""
    @State var title: String = ""
    @State var definition: String = ""
    let creatorId = UserDefaults.standard.integer(forKey: "userId")
    @State var status:Status = .OPEN
    let type:PostType = .POLL
    @State var typeInfo: [String] = ["",""]
    @FocusState private var focusedField: String?
    
    @State var error = ""
    
    var body: some View {
        VStack{
            Section(header: Text("Create Bet").font(.largeTitle)) {
                Form{
                    TextField("Title", text: $title)
                    TextField("Definition", text: $definition, axis: .vertical)
                        .lineLimit(3, reservesSpace: true)
                    
                    List {
                        ForEach(0..<typeInfo.count, id: \.self) { pos in
                            Section(header: Text("Option \(pos+1): ")) {
                                TextField("Answer: ", text: $typeInfo[pos])
                                    .focused($focusedField, equals: "\(pos+1)")
                            }
                        }
                    }
                    
                    Button("Add Answer") {
                        typeInfo.append("")
                    }
                    Button(action: {
                        focusedField = nil
                        if typeInfo.count > 2 {
                            typeInfo.removeLast()
                        }
                    }) {
                        Text("Remove Answer")
                    }
                }
            }
            
            Text(error)
                .foregroundStyle(Color.red)
            
            Spacer(minLength: 40)
            
            Button("Submit", action: {
                Task {
                    if title != "" && definition != "" {
                        error = ""
                        for i in 0..<typeInfo.count {
                            if typeInfo[i] == "" {
                                error = "TextFields must not be empty."
                                return
                            } else {
                                error = ""
                            }
                        }
                        await createPost(createdOn: createdOn, title: title, definition: definition, creatorId: creatorId, status: status, type: type, typeInfo: typeInfo)
                    }else {
                        error = "TextFields must not be empty."
                    }
                }
            })
        }.task {
            let datef = DateFormatter()
            datef.dateFormat = "yyyy-MM-dd"
            createdOn = datef.string(from: Date.now)
        }
    }
}

#Preview {
    CreatePostView()
}
