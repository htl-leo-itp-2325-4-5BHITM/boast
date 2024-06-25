
import SwiftUI

struct TextPostPreview: View {
    var post: Text_PostModel?
    @State var postStatus:Status = .OPEN
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                VStack(alignment: .leading) {
                    Text(post?.title ?? "")
                        .font(.system(size: 30, weight: .semibold))
                }
            }
            VStack(alignment: .leading) {
                Text(post?.definition ?? "")
                    .font(.system(size: 20))
            }
            
            HStack {
                Text("@\(post?.creatorName ?? "")")
                Text("|")
                Text("\(post?.postDetails?.count ?? 0) vote")
                Spacer()
            }
            .font(.system(size: 14))
            .foregroundColor(.gray)
        }
        .frame(width: UIScreen.main.bounds.width - 20)
    }
}
