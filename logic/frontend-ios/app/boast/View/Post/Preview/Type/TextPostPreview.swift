
import SwiftUI

struct TextPostPreview: View {
    var post: Text_PostModel?
    @State var postStatus:Status = .OPEN
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                VStack(alignment: .leading) {
                    NavigationLink(destination: UserProfileView(userId: post?.creatorId ?? -1)) {
                        Text(post?.creatorName ?? "")
                            .font(.title)
                    }
                    Text(post?.createdOn ?? "")
                }
                Spacer()
            }
            
            VStack(alignment: .leading) {
                Text(post?.title ?? "")
                    .bold()
                    .font(.title)
                Text(post?.definition ?? "")
                    .font(.title2)
            }
        }
        .frame(width: UIScreen.main.bounds.width - 20)
    }
}
