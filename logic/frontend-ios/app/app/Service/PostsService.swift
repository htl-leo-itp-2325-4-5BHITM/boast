
import Foundation

func loadPost() async -> PostModel {
    var post = PostModel()
    let url = URL(string: "http://www.boast.social/api/posts/100")!
    if let (data, _) = try? await URLSession.shared.data(from: url) {
        if let getPost = try? JSONDecoder().decode(PostModel.self, from: data) {
            do {
                let postType = try JSONDecoder().decode(TypeModel.self, from: data)
                let type = PostType(rawValue: postType.type!)
                switch type {
                    case .POLL:
                        post = try JSONDecoder().decode(Poll_PostModel.self, from: data)
                    default:
                        break
                }
                
            } catch {
                print(error)
            }
        } else {
            print("failed to decode")
        }
    } else {
        print("failed to load url")
    }
    
    return post
}
