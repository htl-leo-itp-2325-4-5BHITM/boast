

import SwiftUI

/*
 VIEWMODEL IST ARRAY VON  POSTMODELVIEWMODEL ( ELTERNKLASSE )
 */

struct PostsView: View {
    var body: some View {
        Button{
            Task {
                var test: PostModel = try await posts()
            }
        } label: {
            Text("Button")
        }
    }
}

#Preview {
    PostsView()
}
