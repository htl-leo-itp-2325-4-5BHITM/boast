
import SwiftUI

struct CreateTextPost: View {
    @State var title: String = ""
    @State var definition: String = ""
    @State var goNext = false
    let creatorId = UserDefaults.standard.integer(forKey: "userId")
    @State var status:Status = .OPEN    
    @State var error = ""
    
    var body: some View {
        NavigationStack {
            VStack{
                Section(header: Text("Create simple Bet").font(.largeTitle)) {
                    Form{
                        TextField("Title", text: $title)
                        TextField("Definition", text: $definition, axis: .vertical)
                            .lineLimit(3, reservesSpace: true)
                    }
                }
                
                Text(error)
                    .foregroundStyle(Color.red)
                
                Spacer(minLength: 40)
                
                
                Button("Submit", action: {
                    Task {
                        if title != "" && definition != "" {
                            error = ""
                            await createTextPost(title: title, definition: definition, creatorId: creatorId)
                            goNext = true
                        }else {
                            error = "TextFields must not be empty."
                        }
                    }
                })
            }
            NavigationLink(destination: Create().toolbar(.hidden, for: .automatic), isActive: $goNext){}
        }
    }
}

#Preview {
    CreateTextPost()
}
