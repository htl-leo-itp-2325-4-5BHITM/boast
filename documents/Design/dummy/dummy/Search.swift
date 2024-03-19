
import SwiftUI

struct Search: View {
    @State var searchText = ""
    @State var searchIsActive = false
    var body: some View {
        VStack {
            NavigationStack {
                Text("")
                    .navigationTitle("Find your friends")
            }
            .searchable(text: $searchText, isPresented: $searchIsActive)
        }
    }
}

#Preview {
    Search()
}
