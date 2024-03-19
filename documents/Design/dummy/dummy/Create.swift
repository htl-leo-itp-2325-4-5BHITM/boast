
import SwiftUI

struct Create: View {
    @State private var text: String = ""
    @State private var text2: String = ""
    @FocusState private var isFocused: Bool
    var body: some View {
        VStack {
            Form {
                Section(header: Text("Create your bet")) {
                    TextField("Bet: ", text: $text)
                        .font(.callout)
                        .focused($isFocused)
                    TextField("Stakes: ", text: $text2)
                        .font(.callout)
                        .focused($isFocused)

                }
            }
            if isFocused {
                HStack {
                    Image(systemName: "dollarsign.circle")
                        .resizable()
                        .scaledToFit()
                    Image(systemName: "chart.pie")
                        .resizable()
                        .scaledToFit()
                    Image(systemName: "photo.stack")
                        .resizable()
                        .scaledToFit()
                    Image(systemName: "clock")
                        .resizable()
                        .scaledToFit()
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
