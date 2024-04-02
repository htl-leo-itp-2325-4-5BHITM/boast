
import SwiftUI

struct Create: View {
    let creatorId = UserDefaults.standard.integer(forKey: "userId")
    @State var title: String = ""
    @State var definition: String = ""
    @FocusState private var isFocused: Bool
    @State var poll = false
    @State var text = false
    @State var typeInfo: [String] = ["",""]
    @FocusState private var focusedField: String?
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Title", text: $title)
                        .focused($isFocused)
                    TextField("Definition", text: $definition, axis: .vertical)
                        .lineLimit(3, reservesSpace: true)
                        .focused($isFocused)
                } header: {
                    Text("create your bet")
                }
                
                if poll {
                    List {
                        ForEach(0..<typeInfo.count, id: \.self) { pos in
                            TextField("Option \(pos+1)", text: $typeInfo[pos])
                                .focused($focusedField, equals: "\(pos+1)")
                        }
                        HStack {
                            Spacer()
                            Button("+") {
                                typeInfo.append("")
                            }
                            .buttonStyle(.borderedProminent)
                            Button(action: {
                                Task {
                                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                                    if typeInfo.count > 2 {
                                        typeInfo.removeLast()
                                    }
                                }
                            }) {
                                Text("-")
                            }
                            .buttonStyle(.borderedProminent)
                        }
                        .padding(1)
                    }
                }
                
                Section {
                    Button("Submit", action: {
                        Task {
                            if title != "" && definition != "" {
                                if poll {
                                    for i in 0..<typeInfo.count {
                                        if typeInfo[i] == "" {
                                            return
                                        }
                                    }
                                    await createPollPost(title: title, definition: definition, creatorId: creatorId, status: .OPEN, type: .POLL, typeInfo: typeInfo)
                                } else {
                                    await createTextPost(title: title, definition: definition, creatorId: creatorId)
                                }
                            }
                        }
                    }).padding(1)
                }
            }
            
            Spacer()
            
            if isFocused || focusedField != nil {
                HStack {
                    Button(action: {
                        poll.toggle()
                    }, label: {
                        Image(systemName: "chart.pie")
                            .resizable()
                            .scaledToFit()
                            .foregroundStyle(.blackAndWhite)
                    })
                    /*
                     Button(action: {
                     poll = false
                     text = true
                     }, label: {
                     Image(systemName: "character.cursor.ibeam")
                     .resizable()
                     .scaledToFit()
                     .foregroundStyle(.blackAndWhite)
                     })
                     */
                    Spacer()
                }
                .padding(.leading)
                .padding(.bottom)
                .frame(height: 50)
                .ignoresSafeArea(.keyboard, edges: .bottom)
            }
        }
    }
}

#Preview {
    Create()
}
