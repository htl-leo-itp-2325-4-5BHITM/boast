
import Foundation

func loadPost(postId: Int) async -> PostModel {
    var post = PostModel()
    let url = URL(string: "http://www.boast.social/api/posts/\(postId)")!
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

func posts() async -> [Int] {
    var postList: [Int] = []
    let url = URL(string: "http://www.boast.social/api/posts")!
    if let (data, _) = try? await URLSession.shared.data(from: url) {
        postList = try! JSONDecoder().decode([Int].self, from: data)
    } else {
        print("failed to load url")
    }
    return postList
}
