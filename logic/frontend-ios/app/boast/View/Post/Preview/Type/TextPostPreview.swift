
import SwiftUI

struct TextPostPreview: View {
    var post: Text_PostModel?
    @State var postStatus:Status = .OPEN
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                VStack(alignment: .leading) {
                    Text(post?.creatorName ?? "")
                    Text(post?.createdOn ?? "")
                }
                Spacer()
            }
            
            VStack(alignment: .leading) {
                Text(post?.title ?? "")
                Text(post?.definition ?? "")
            }
            
            VStack(alignment: .leading) {
                ForEach(post?.postDetails ?? [Text_PostDetailModel](), id: \.postDetailsId) { detail in
                    HStack {
                        Text(detail.createdOn ?? "")
                        Text("\(detail.creatorName ?? "") :")
                    }
                }
            }
        }
        .frame(width: UIScreen.main.bounds.width - 20)
    }
}
