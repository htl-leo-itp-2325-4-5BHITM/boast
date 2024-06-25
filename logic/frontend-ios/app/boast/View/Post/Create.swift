
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
    @State var navigateToPost = false
    @State var postId = -1
    
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
                    Text("Submit")
                        .onTapGesture {
                            Task {
                                if title != "" && definition != "" {
                                    if poll {
                                        for i in 0..<typeInfo.count {
                                            if typeInfo[i] == "" {
                                                return
                                            }
                                        }
                                        postId = await createPollPost(title: title, definition: definition, creatorId: creatorId, status: .OPEN, type: .POLL, typeInfo: typeInfo)
                                        title = ""
                                        definition = ""
                                        poll = false
                                        text = false
                                        typeInfo = ["",""]
                                        
                                        print("\(postId) adfasdfasd")
                                        
                                        if postId != -1 {
                                            navigateToPost = true
                                        }
                                        
                                    } else {
                                        postId = await createTextPost(title: title, definition: definition, creatorId: creatorId)
                                        title = ""
                                        definition = ""
                                        poll = false
                                        text = false
                                        typeInfo = ["",""]
                                        print("\(postId) adfasdfasd")
                                        if postId != -1 {
                                            navigateToPost = true
                                        }
                                    }
                                }
                            }
                        }
                        .padding(1)
                        .foregroundStyle(.blue)
                }
            }
            .onTapGesture {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to:nil, from:nil, for:nil)
            }
            
            Spacer()
                .navigationDestination(isPresented: $navigateToPost) {
                    Post(postId: postId)
                }
            
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
