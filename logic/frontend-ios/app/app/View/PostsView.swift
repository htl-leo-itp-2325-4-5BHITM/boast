

import SwiftUI

/*
 VIEWMODEL IST ARRAY VON  POSTMODELVIEWMODEL ( ELTERNKLASSE )
 */

struct PostsView: View {
    @ObservedObject var viewModel : PollPostViewModel
    var body: some View {
        Button{
            Task {
                posts()
            }
        } label: {
            Text("Button")
        }
    }
}
