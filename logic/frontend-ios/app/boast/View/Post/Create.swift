
import SwiftUI

struct Create: View {
    var body: some View {
        NavigationView {
            NavigationLink(destination: CreatePollPost()) {
                Text("Create new Poll Post")
            }
            NavigationLink(destination: CreatePollPost()) {
                Text("Create new Text Post")
            }
        }
    }
}

#Preview {
    Create()
}
