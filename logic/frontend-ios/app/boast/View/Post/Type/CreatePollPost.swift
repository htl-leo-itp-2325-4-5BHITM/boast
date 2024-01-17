
import SwiftUI

struct CreatePollPost: View {
    @State var title: String = ""
    @State var definition: String = ""
    let creatorId = UserDefaults.standard.integer(forKey: "userId")
    @State var status:Status = .OPEN
    let type:PostType = .POLL
    @State var typeInfo: [String] = ["",""]
    @FocusState private var focusedField: String?
    @State var error = ""
    @State var goNext = false
    
    var body: some View {
        NavigationStack {
            VStack{
                Section(header: Text("Create Poll Bet").font(.largeTitle)) {
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
                            Task {
                                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                                if typeInfo.count > 2 {
                                    await typeInfo.removeLast()
                                }
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
                            let status = await createPollPost(title: title, definition: definition, creatorId: creatorId, status: status, type: type, typeInfo: typeInfo)
                            goNext = true
                        }else {
                            error = "TextFields must not be empty."
                        }
                    }
                })
                
                NavigationLink(destination: Create().toolbar(.hidden, for: .automatic), isActive: $goNext){}
            }
        }
    }
}

#Preview {
    CreatePollPost()
}
