
import SwiftUI

struct Create: View {
    var body: some View {
        NavigationStack {
            VStack {
                Text("Create: ")
                    .font(.largeTitle)
                List {
                    NavigationLink(destination: CreatePollPost()) {
                        Text("Create new Poll Post")
                    }

                    NavigationLink(destination: CreateTextPost()) {
                        Text("Create new Text Post")
                    }
                }
            }
        }
    }
}

#Preview {
    Create()
}
