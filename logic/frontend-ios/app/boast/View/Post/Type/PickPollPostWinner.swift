
import SwiftUI

struct PickPollPostWinner: View {
    var post: PollPostViewModel
    @State var selectedItems = Set<postAnswers>()
    var body: some View {
        NavigationStack {
            VStack {
                List(selection: $selectedItems) {
                        
                }
            }
        }
        .task {
        }
    
    }
}
