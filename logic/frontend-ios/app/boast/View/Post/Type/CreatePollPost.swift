
import SwiftUI

struct CreatePollPost: View {
    @State var title: String = ""
    @State var definition: String = ""
    let creatorId = UserDefaults.standard.integer(forKey: "userId")
    @State var status:Status = .OPEN
    let type:PostType = .POLL
    @State var typeInfo: [String] = ["",""]
    @FocusState private var focusedField: String?
    @State var error = false
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
                                TextField("Option \(pos+1)", text: $typeInfo[pos])
                                    .focused($focusedField, equals: "\(pos+1)")
                            }
                        }
                        
                        Section {
                            HStack {
                                Button("Add Answer") {
                                    typeInfo.append("")
                                }
                                .buttonStyle(.borderedProminent)
                                Spacer()
                                Button(action: {
                                    Task {
                                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                                        if typeInfo.count > 2 {
                                            typeInfo.removeLast()
                                        }
                                    }
                                }) {
                                    Text("Remove Answer")
                                }
                                .buttonStyle(.borderedProminent)
                            }
                        }
                        .listRowBackground(Color.clear)
                        
                        Button("Submit", action: {
                            Task {
                                if title != "" && definition != "" {
                                    for i in 0..<typeInfo.count {
                                        if typeInfo[i] == "" {
                                            return
                                        }
                                    }
                                    _ = await createPollPost(title: title, definition: definition, creatorId: creatorId, status: status, type: type, typeInfo: typeInfo)
                                    goNext = true
                                }
                                error = true
                            }
                        })
                    }
                }
                NavigationLink(destination: Create().toolbar(.hidden, for: .automatic), isActive: $goNext){}
            }
            .overlay(alignment: .bottom) {
                if error == true {
                    ErrorOverlayView()
                        .padding(.bottom)
                }
            }
        }
    }
}

#Preview {
    CreatePollPost()
}
